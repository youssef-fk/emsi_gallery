import 'dart:typed_data';

import 'dart:ui';

class FaceAndId {
  final Uint8List faceData;
  final int id;
  final Rect box;

  FaceAndId(this.faceData, this.id, this.box);
}
