import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../services/auth/auth_service.dart';
import '../../../../services/map/map_service.dart';
import '../../../../services/map/models/city.dart';
import '../../../../services/navigation/navigation_service.dart';
import '../../gallery/gallery_view.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapService mapService;
  final NavigationService navigationService;
  final AuthService authService;

  MapBloc({
    @required this.mapService,
    @required this.navigationService,
    @required this.authService,
  });

  @override
  MapState get initialState => MapInitial();

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is GetUserPositionEvent) {
      final cities = await mapService.cities;

      final geolocator = Geolocator();
      GeolocationStatus geolocationStatus = await geolocator.checkGeolocationPermissionStatus();

      // print(geolocationStatus.value);
      // if(geolocationStatus.value == 0) {
      //   geolocator.
      // }

      // if (geolocationStatus.value != 0) {
      await Permission.location.request();

      final position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      final latlng = LatLng(
        position.latitude,
        position.longitude,
      );

      final currentMarker = Marker(
        position: latlng,
        markerId: MarkerId('current'),
        infoWindow: InfoWindow(
          title: 'I am here.',
        ),
      );

      final siteMarkers = await affectSites(cities, navigationService);

      yield Loaded(
        cities: cities,
        position: latlng,
        currentMarker: currentMarker,
        markers: siteMarkers.toSet()..add(currentMarker),
      );
      // }
    }
  }

  Future<List<Marker>> affectSites(
    List<City> cities,
    NavigationService navigationService,
  ) async {
    // ! To REMOVE LATER WHEN ADDInG GRID BOXES
    final userProfile = await this.authService.userProfile;
    final sites = <Marker>[];

    final icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(16, 16),
      ),
      'assets/images/emsi.jpg',
    );

    for (final city in cities) {
      for (final site in city.sites) {
        final sameSite = userProfile.site.name == site.name;

        final args = GalleryArguments(
          site: site,
          expectedGraduationYear: sameSite ? userProfile.expectedGraduationYear : null,
          promoField: sameSite ? userProfile.promo.promoField : null,
        );

        sites.add(
          Marker(
            markerId: MarkerId(site.name),
            position: LatLng(site.coords.latitude, site.coords.longitude),
            infoWindow: InfoWindow(
              title: site.name,
            ),
            icon: icon,
            onTap: () => navigationService.push(
              GalleryView.routeName,
              args: args,
            ),
          ),
        );
      }
    }

    return sites;
  }
}
