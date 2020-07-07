import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:emsi_gallery/ui/views/gallery/gallery_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../../services/auth/auth_service.dart';
import '../../../../services/auth/models/promo/promo.dart';
import '../../../../services/auth/models/user_profile/user_profile.dart';
import '../../../../services/gallery/database_storage.dart';
import '../../../../services/gallery/face_detector_service.dart';
import '../../../../services/gallery/firebase_storage.dart';
import '../../../../services/map/map_service.dart';
import '../../../../services/map/models/city.dart';
import '../../../../services/map/models/site.dart';
import '../../../../services/navigation/navigation_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;
  final NavigationService navigationService;
  final MapService mapService;
  final GalleryFaceDetectorService faceDetectorService;
  final GalleryFirebaseStorage firebaseStorageService;
  final GalleryDatabaseStorageService databaseStorageService;

  FirebaseUser user;
  List<City> cities;
  File userImage;
  bool hasFace = false;

  UserProfile userProfile;

  LoginBloc({
    @required this.authService,
    @required this.navigationService,
    @required this.mapService,
    @required this.faceDetectorService,
    @required this.firebaseStorageService,
    @required this.databaseStorageService,
  });
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithGoogleEvent) {
      yield Loading();
      // yield* _yieldMoreInfo();

      final user = await authService.loginWithGoogle();

      if (user != null) {
        final imageId = await ImageDownloader.downloadImage(user.photoUrl);
        final imagePath = await ImageDownloader.findPath(imageId);

        final image = File(imagePath);
        userImage = image;

        final userProfile = await authService.userProfile;

        if (userProfile == null) {
          yield* _yieldMoreInfo();
        } else {
          _navigateToGallery(userProfile.site);
        }
      } else {
        yield LoginError();
      }
    }

    if (event is SaveUserProfileEvent) {
      this.userProfile = UserProfile(
        uuid: Uuid().v1(),
        site: event.site,
        name: event.userName,
        profilePhoto: userImage,
        promo: Promo(
          event.year,
          event.promoField.index,
        ),
      );

      final uploadTask = firebaseStorageService.saveImageProfile(
        image: this.userImage,
        userProfile: userProfile,
      );

      final image = await uploadTask.onComplete;
      final path = image.storageMetadata.path;

      userProfile.imagePath = path;

      print('path');

      authService.saveUserProfile(userProfile);
      databaseStorageService.addUserProfile(userProfile: userProfile);

      _navigateToGallery(userProfile.site);
    }

    if (event is PickImageEvent) {
      File imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (imageFile != null) {
        final cropped = await ImageCropper.cropImage(
          sourcePath: imageFile.path,
          compressFormat: ImageCompressFormat.jpg,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          cropStyle: CropStyle.circle,
        );

        this.userImage = cropped ?? imageFile;

        this.hasFace = await faceDetectorService.containsFace(userImage);
        print("DOES IT HAVE A FACE ? $hasFace");

        yield* _yieldMoreInfo();
      }
    }
  }

  Stream<LoginState> _yieldMoreInfo() async* {
    yield MoreInfo(
      cities: cities ?? await mapService.cities,
      userImage: userImage,
      hasFace: hasFace,
    );
  }

  void _navigateToGallery(Site site) {
    // //! Should POP
    // this.navigationService.pop();
    navigationService.replace(
      GalleryView.routeName,
      args: GalleryArguments(
        site: site,
        expectedGraduationYear: this.userProfile.expectedGraduationYear,
        promoField: this.userProfile.promo.promoField,
      ),
    );
  }
}
