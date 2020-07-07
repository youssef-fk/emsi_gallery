import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../global/download_image.dart';
import '../../../../global/extensions/face_extension.dart';
import '../../../../services/auth/auth_service.dart';
import '../../../../services/auth/models/user_profile/user_profile.dart';
import '../../../../services/gallery/database_storage.dart';
import '../../../../services/gallery/face_detector_service.dart';
import '../../../../services/gallery/firebase_storage.dart';
import '../../../../services/gallery/models/app_image/app_image.dart';
import '../../../../services/gallery/models/face_and_id.dart';
import '../../../../services/navigation/navigation_service.dart';
import '../../grid_gallery/grid_gallery_view.dart';
import '../../map/map_view.dart';
import '../../upload/upload_intent_view.dart';
import '../gallery_view.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final appImagesData = <AppImageData>[];

  final AuthService authService;
  final GalleryDatabaseStorageService databaseStorageService;
  final GalleryFirebaseStorage firebaseStorage;
  final NavigationService navigationService;
  final GalleryFaceDetectorService faceDetectorService;

  GalleryArguments galleryArguments;

  GalleryBloc({
    @required this.navigationService,
    @required this.databaseStorageService,
    @required this.firebaseStorage,
    @required this.authService,
    @required this.faceDetectorService,
  });

  UserProfile _userProfile;
  String _userProfileImageUrl;
  bool _isUsersClass = false;

  UserProfile get userProfile => _userProfile;
  String get userProfileImageUrl => _userProfileImageUrl;
  bool get isUsersClass => _isUsersClass;

  @override
  GalleryState get initialState => GalleryInitial();

  Future<File> get _pickImageFromGallery async {
    return await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
  }

  Future<File> get _pickImageFromCamera async {
    return await ImagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 70,
    );
  }

  @override
  Stream<GalleryState> mapEventToState(
    GalleryEvent event,
  ) async* {
    if (event is PickImageEvent) {
      yield* _pickImageFromEvent(event);
    }

    if (event is LoadAppImagesEvent) {
      this.galleryArguments = event.galleryArguments;

      this._userProfile = await authService.userProfile;
      this._userProfileImageUrl = await firebaseStorage.getImageUrl(
        path: this._userProfile.imagePath,
      );
      this._isUsersClass = this.userProfile.isSameClass(
            this.galleryArguments.site.name,
            this.galleryArguments.expectedGraduationYear,
            this.galleryArguments.promoField,
          );

      final stream = this.databaseStorageService.getAppImagesStream(
            expectedGraduationYear: galleryArguments.expectedGraduationYear,
            site: this.galleryArguments.site,
            promoField: this.galleryArguments.promoField,
          );

      stream.listen(
        (querySnapshot) => this.add(
          AppImageSnapshotEvent(snapshot: querySnapshot),
        ),
      );
    }

    if (event is AppImageSnapshotEvent) {
      final appImages = this.databaseStorageService.documentsToAppImages(
            event.snapshot.documents,
          )..retainWhere(
              (element) =>
                  this.appImagesData.singleWhere(
                        (e) => e.appImage.timestamp.isAtSameMomentAs(element.timestamp),
                        orElse: () => null,
                      ) ==
                  null,
            );

      if (appImages.isEmpty) {
        final message = this.userProfile.expectedGraduationYear ==
                    this.galleryArguments.expectedGraduationYear &&
                this.userProfile.promo.promoField == this.galleryArguments.promoField &&
                this.userProfile.site.name == this.galleryArguments.site.name
            ? NoDataState.thisUser
            : NoDataState.notThisUser;

        yield NoDataState(message: message);
      } else {
        await Future.wait(appImages.map(
          (appImage) async {
            final imageUrl = await firebaseStorage.getImageUrl(
              path: appImage.imagePath,
            );

            final image = await downloadImage(imageUrl);

            final faces = await Future.wait(
              appImage.taggedUsers.map(
                (user) async {
                  final rect = user.box.rect;
                  return FaceAndId(
                    await getFaceFromImage(rect: rect, imageBytes: image),
                    user.faceId,
                    rect,
                  );
                },
              ),
            );

            appImagesData.add(
              AppImageData(appImage: appImage, image: image, faces: faces),
            );
          },
        ));

        // sort
        appImagesData.sort(
          (e1, e2) => -e1.appImage.timestamp.compareTo(e2.appImage.timestamp),
        );

        //Getting user profiles
        final uuidSet = appImagesData
            .map(
              (e) => e.appImage.posterProfileUuid,
            )
            .toSet();

        final posters = await databaseStorageService.getUserProfiles(
          uuidList: uuidSet.toList(),
          site: galleryArguments.site,
          promoField: galleryArguments.promoField,
          expectedGraduationYear: galleryArguments.expectedGraduationYear,
        );

        final customPosters = await Future.wait(posters
            .map((poster) async => CustromPoster(
                imageUrl: await this.firebaseStorage.getImageUrl(path: poster.imagePath),
                poster: poster))
            .toList());

        yield Loaded(
          appImagesData: appImagesData,
          posters: customPosters,
        );
      }
    }

    if (event is NavigateToMapEvent) {
      navigationService.push(MapView.routeName);
    }

    if (event is OnPressGridEvent) {
      navigationService.push(
        GridGalleryView.routeName,
        args: GridGalleryViewArgs(siteName: event.siteName),
      );
    }
  }

  Stream<GalleryState> _pickImageFromEvent(PickImageEvent event) async* {
    final imageFile = (event is PickFromGalleryEvent
            ? await _pickImageFromGallery
            : await _pickImageFromCamera) ??
        await retrieveLostData();

    if (imageFile?.path != null) {
      navigationService.push(
        UploadIntentView.routeName,
        args: UploadIntentViewArgs(image: imageFile),
      );
    }
  }
}

Future<File> retrieveLostData() async {
  final LostDataResponse response = await ImagePicker.retrieveLostData();

  if (response == null) {
    return null;
  }

  return response.file;
}
