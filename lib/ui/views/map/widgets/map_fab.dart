import 'package:emsi_gallery/services/map/models/city.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MapFab extends StatefulWidget {
  final List<City> cities;
  final Function onPress;

  const MapFab({Key key, @required this.cities, @required this.onPress}) : super(key: key);
  @override
  _MapFabState createState() => _MapFabState();
}

class _MapFabState extends State<MapFab> {
  bool isExpanded = false;

  void setExpanded(bool value) => this.setState(
        () => isExpanded = value,
      );

  @override
  Widget build(BuildContext context) {
    final cities = widget.cities;
    final _children = <SpeedDialChild>[];
    cities.forEach((city) {
      city.sites.forEach(
        (site) {
          final child = _renderSpeedDialChild(
            site.name,
            () => widget.onPress(site.coords.latitude, site.coords.longitude),
          );
          _children.add(child);
        },
      );
    });

    return SpeedDial(
      marginRight: 18,
      marginBottom: 20,
      child: Icon(
        Icons.search,
        color: Colors.white,
      ),
      onOpen: () => this.setExpanded(true),
      onClose: () => this.setExpanded(false),
      overlayOpacity: 0.5,
      curve: Curves.bounceIn,
      closeManually: false,
      children: _children,
    );
  }
}

SpeedDialChild _renderSpeedDialChild(String label, Function onTap) => SpeedDialChild(
      child: Icon(Icons.pin_drop, color: Colors.white),
      label: label,
      onTap: onTap,
    );
