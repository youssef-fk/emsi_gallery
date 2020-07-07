part of 'map_bloc.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {}

class Loaded extends MapState {
  final List<City> cities;
  final LatLng position;
  final Marker currentMarker;
  final Set<Marker> markers;

  Loaded({
    @required this.cities,
    @required this.position,
    @required this.currentMarker,
    @required this.markers,
  });
}

Marker affectCurrent(LatLng position) => Marker(
      position: position,
      markerId: MarkerId('current'),
      infoWindow: InfoWindow(
        title: 'I am here.',
      ),
    );
