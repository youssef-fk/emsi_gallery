import 'package:emsi_gallery/services/grid_gallery/grid_gallery_service.dart';
import 'package:emsi_gallery/services/grid_gallery/grid_gallery_service_impl.dart';
import 'package:emsi_gallery/ui/views/grid_gallery/bloc/grid_gallery_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth/auth_service.dart';
import '../services/gallery/database_storage.dart';
import '../services/gallery/face_detector_service.dart';
import '../services/gallery/firebase_storage.dart';
import '../services/map/map_service.dart';
import '../services/navigation/navigation_service.dart';
import '../ui/views/gallery/bloc/gallery_bloc.dart';
import '../ui/views/login/bloc/login_bloc.dart';
import '../ui/views/map/bloc/map_bloc.dart';
import '../ui/views/startup/bloc/startup_bloc.dart';
import '../ui/views/upload/bloc/upload_bloc.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  //Blocs
  locator.registerFactory(
    () => StartupBloc(
      authService: locator(),
      navigationService: locator(),
    ),
  );
  locator.registerFactory(
    () => LoginBloc(
      authService: locator(),
      navigationService: locator(),
      mapService: locator(),
      faceDetectorService: locator(),
      databaseStorageService: locator(),
      firebaseStorageService: locator(),
    ),
  );

  locator.registerFactory(
    () => MapBloc(
      mapService: locator(),
      navigationService: locator(),
      authService: locator(),
    ),
  );

  locator.registerFactory(
    () => GalleryBloc(
      navigationService: locator(),
      authService: locator(),
      databaseStorageService: locator(),
      firebaseStorage: locator(),
      faceDetectorService: locator(),
    ),
  );

  locator.registerFactory(
    () => UploadBloc(
      databaseStorageService: locator(),
      faceDetectorService: locator(),
      authService: locator(),
      firebaseStorage: locator(),
      gridGalleryService: locator(),
    ),
  );

  locator.registerFactory(
    () => GridGalleryBloc(
      gridGalleryService: locator(),
      authService: locator(),
      navigationService: locator(),
      mapService: locator(),
    ),
  );

  // Services
  locator.registerLazySingleton<AuthService>(
    () => AuthServiceImpl(
      sharedPreferences: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => NavigationService(),
  );

  locator.registerLazySingleton<MapService>(
    () => MapServiceImpl(),
  );

  //! Gallery

  locator.registerLazySingleton<GalleryFaceDetectorService>(
    () => GalleryFaceDetectorServiceImpl(),
  );
  locator.registerLazySingleton<GalleryFirebaseStorage>(
    () => GalleryFirebaseStorageImpl(),
  );
  locator.registerLazySingleton<GalleryDatabaseStorageService>(
    () => GalleryDatabaseStorageServiceImpl(),
  );
  locator.registerLazySingleton<GridGalleryService>(
    () => GridGalleryServiceImpl(),
  );

  //Utils
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(
    () => sharedPreferences,
  );
}
