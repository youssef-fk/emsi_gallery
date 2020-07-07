import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:meta/meta.dart';

import '../../../../global/painter/rect_painter.dart';
import '../../../../services/auth/auth_service.dart';
import '../../../../services/auth/models/user_profile/user_profile.dart';
import '../../../../services/gallery/database_storage.dart';
import '../../../../services/gallery/face_detector_service.dart';
import '../../../../services/gallery/firebase_storage.dart';
import '../../../../services/gallery/models/app_image/app_image.dart';
import '../../../../services/gallery/models/face_and_id.dart';
import '../../../../services/gallery/models/rect/rect_model.dart';
import '../../../../services/gallery/models/user/user.dart';
import '../../../../services/grid_gallery/grid_gallery_service.dart';
import '../../gallery/bloc/gallery_bloc.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final GalleryFaceDetectorService faceDetectorService;
  final GalleryFirebaseStorage firebaseStorage;
  final AuthService authService;
  final GalleryDatabaseStorageService databaseStorageService;
  final GridGalleryService gridGalleryService;

  File image;
  String title = '';
  List<User> users = [];
  UserProfile _userProfile;

  Loaded loadedState;

  UploadBloc({
    @required this.faceDetectorService,
    @required this.firebaseStorage,
    @required this.authService,
    @required this.databaseStorageService,
    @required this.gridGalleryService,
  }) {
    authService.userProfile.then((value) => _userProfile = value);
  }

  void initUsers(List<FaceAndId> faceAndIds) {
    users = faceAndIds
        .map(
          (e) => User(name: '', faceId: e.id, box: getRectModelFromRect(e.box)),
        )
        .toList();
  }

  void setTitle(String value) {
    title = value;
  }

  void setUserName(String value, FaceAndId faceAndId) {
    final user = users.singleWhere((element) => element.faceId == faceAndId.id);
    users.remove(user);

    users = <User>[]
      ..addAll(users)
      ..add(
        user.copyWith(name: value),
      );
  }

  String getUserName(int faceId) {
    final name = users.singleWhere((element) => element.faceId == faceId, orElse: () => null)?.name;
    return name == '' ? null : name;
  }

  @override
  UploadState get initialState => UploadInitial();

  @override
  Stream<UploadState> mapEventToState(
    UploadEvent event,
  ) async* {
    if (event is PrepareImageEvent) {
      yield* _pickImageEvent(event.imageFile);
    }

    if (event is UploadImageEvent) {
      print('SAVE IMAGE !!!');
      final uploadStream = firebaseStorage.saveImage(
        image: this.image,
        userProfile: this._userProfile,
      );

      yield UploadingImage(uploadStream: uploadStream, state: this.loadedState);
    }

    if (event is UploadFinishedEvent) {
      final title = this.title == '' ? '' : this.title[0].toUpperCase() + this.title.substring(1);

      final appImage = AppImage(
        imagePath: event.imagePath,
        taggedUsers: this.users,
        timestamp: DateTime.now(),
        title: title,
        posterProfileUuid: this._userProfile.uuid,
      );

      databaseStorageService.addImage(
        userProfile: this._userProfile,
        appImage: appImage,
      );

      gridGalleryService.saveMajorYear(
        siteName: this._userProfile.site.name,
        majorName: this._userProfile.promoName,
        year: this._userProfile.expectedGraduationYear,
      );

      yield Aborted();
    }

    if (event is SetTitleEvent) setTitle(event.title);
    if (event is SetUserNameEvent) {
      setUserName(event.name, event.faceAndId);
      yield Loaded(
        faceAndIds: this.loadedState.faceAndIds,
        facePainter: this.loadedState.facePainter,
        image: this.loadedState.image,
        profiles: this.loadedState.profiles,
      );
    }
  }

  Stream<UploadState> _pickImageEvent(File imageFile) async* {
    yield Loading();

    // crop
    if (imageFile != null) {
      final cropped = await ImageCropper.cropImage(sourcePath: imageFile.path, aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ]);

      if (cropped == null) {
        yield Aborted();
      } else {
        this.image = cropped;

        final image = await cropped.readAsBytes();
        final decodedImage = await decodeImageFromList(image);

        final faceAndIds = await this.faceDetectorService.extractFaces(
              this.image,
            );

        final rects = faceAndIds.map((e) => e.box).toList();

        final facePainter = RectPainter(rects: rects, image: decodedImage);

        this.initUsers(faceAndIds);

        final profiles = await databaseStorageService.getAllUserProfiles(
          site: this._userProfile.site,
          promoField: this._userProfile.promo.promoField,
          expectedGraduationYear: this._userProfile.expectedGraduationYear,
        );

        final customPosters = await Future.wait(profiles
            .map((poster) async => CustromPoster(
                imageUrl: await this.firebaseStorage.getImageUrl(path: poster.imagePath),
                poster: poster))
            .toList());

        this.loadedState = Loaded(
          facePainter: facePainter,
          image: decodedImage,
          faceAndIds: faceAndIds,
          profiles: customPosters,
        );

        yield this.loadedState;
      }
    }
  }
}
