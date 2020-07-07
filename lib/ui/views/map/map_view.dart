import 'dart:async';

import 'package:emsi_gallery/ui/views/map/widgets/map_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../global/locator.dart';
import '../../../services/map/models/site.dart';
import 'bloc/map_bloc.dart';
import 'widgets/drawer_row.dart';

class MapView extends StatelessWidget {
  static const routeName = '/map';

  final _controller = Completer<GoogleMapController>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> animateTo(double latitude, double longitude) async {
    final latLng = LatLng(latitude, longitude);

    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: latLng,
        zoom: 18,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final transparentDivider = Theme.of(context).copyWith(
      dividerColor: Colors.transparent,
    );

    // Widget renderDrawerRow(Site site) {
    //   return DrawerRow(
    //     title: site.name,
    //     onTap: () {
    //       animateTo(LatLng(
    //         site.coords.latitude,
    //         site.coords.longitude,
    //       ));
    //       Navigator.of(context).pop();
    //     },
    //   );
    // }

    return BlocProvider(
      create: (context) => locator<MapBloc>(),
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          print(state.runtimeType);

          if (state is MapInitial) {
            context.bloc<MapBloc>().add(GetUserPositionEvent());
          }

          if (state is Loaded) {
            final cameraPosition = CameraPosition(
              target: state.position,
              zoom: 14.76,
            );

            return Scaffold(
              key: _scaffoldKey,
              floatingActionButton: MapFab(
                cities: state.cities,
                onPress: this.animateTo,
              ),
              // floatingActionButton: FloatingActionButton.extended(
              //   icon: Icon(Icons.pin_drop, color: Colors.white),
              //   label: Text('Sites', style: TextStyle(color: Colors.white)),
              //   onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
              //   isExtended: true,
              //   heroTag: 'mapToGallery',
              // ),
              appBar: AppBar(
                title: Text('Map'),
              ),
              body: GoogleMap(
                mapType: MapType.terrain,
                initialCameraPosition: cameraPosition,
                onMapCreated: (controller) {
                  _controller.complete(controller);
                },
                markers: state.markers,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Map'),
            ),
            body: Center(
              child: Scaffold(
                body: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );

          // endDrawerEnableOpenDragGesture: false,
          // endDrawer: Drawer(
          //   child: ListView(
          //     children: <Widget>[
          //       renderDrawerHeader(),
          //       ...() {
          //         if (state is Loaded) {
          //           return state.cities.map(
          //             (city) {
          //               if (city.sites.length == 1) {
          //                 return Column(
          //                   children: <Widget>[
          //                     renderDrawerRow(city.sites[0]),
          //                     Divider(),
          //                   ],
          //                 );
          //               }
          //               return Column(
          //                 children: <Widget>[
          //                   Theme(
          //                     data: transparentDivider,
          //                     child: ExpansionTile(
          //                       leading: Icon(Icons.location_city),
          //                       title: Text(city.name),
          //                       children: city.sites.map(renderDrawerRow).toList(),
          //                     ),
          //                   ),
          //                   Divider(),
          //                 ],
          //               );
          //             },
          //           ).toList();
          //         } else {
          //           return <Widget>[];
          //         }
          //       }(),
          //     ],
          //   ),
          // ),
        },
      ),
    );
  }
}

DrawerHeader renderDrawerHeader() {
  return DrawerHeader(
    child: Center(
      child: Text(
        'Emsi Gallery',
        style: TextStyle(
          fontSize: 20,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
    ),
  );
}
