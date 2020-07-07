import 'package:emsi_gallery/ui/views/gallery/gallery_view.dart';
import 'package:emsi_gallery/ui/views/grid_gallery/grid_gallery_view.dart';
import 'package:emsi_gallery/ui/views/map/map_view.dart';
import 'package:emsi_gallery/ui/views/upload/upload_intent_view.dart';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

import 'global/locator.dart';
import 'services/navigation/navigation_service.dart';
import 'ui/views/login/login_view.dart';
import 'ui/views/startup/startup_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //! REMOVE EVERYTHIN WIPE
  // (await getApplicationDocumentsDirectory()).delete(recursive: true);

  await initLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: locator<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
      routes: {
        LoginView.routeName: (_) => LoginView(),
        MapView.routeName: (_) => MapView(),
        StartupView.routeName: (_) => StartupView(),
        GalleryView.routeName: (_) => GalleryView(),
        UploadIntentView.routeName: (_) => UploadIntentView(),
        GridGalleryView.routeName: (_) => GridGalleryView(),
      },
      initialRoute: StartupView.routeName,
      // initialRoute: LoginView.routeName,
      title: 'Emsi Photo Book',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.green.shade400,
      ),
    );
  }
}
