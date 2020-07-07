import 'dart:math' as math;
import 'package:emsi_gallery/ui/views/gallery/bloc/gallery_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CustomFAB extends StatefulWidget {
  @override
  CustomFABState createState() => CustomFABState();
}

class CustomFABState extends State<CustomFAB> {
  bool isExpanded = false;

  void setExpanded(bool value) {
    return setState(() {
      isExpanded = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GalleryBloc, GalleryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SpeedDial(
          marginRight: 18,
          marginBottom: 20,
          child: Transform.rotate(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            angle: isExpanded ? math.pi / 4 : 0,
          ),
          onOpen: () => setExpanded(true),
          onClose: () => setExpanded(false),
          overlayOpacity: 0.5,
          curve: Curves.bounceIn,
          closeManually: false,
          children: [
            SpeedDialChild(
              child: Icon(
                Icons.photo_camera,
                color: Colors.white,
              ),
              label: 'Camera',
              onTap: () {
                context.bloc<GalleryBloc>().add(PickFromCameraEvent());
              },
            ),
            SpeedDialChild(
              child: Icon(
                Icons.image,
                color: Colors.white,
              ),
              label: 'Gallery',
              onTap: () {
                context.bloc<GalleryBloc>().add(PickFromGalleryEvent());
              },
            ),
          ],
        );
      },
    );
  }
}
