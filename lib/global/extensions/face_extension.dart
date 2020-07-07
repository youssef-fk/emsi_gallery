import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image/image.dart';

Future<List<Rect>> formatRects({
  @required File imageFile,
  @required List<Rect> rects,
}) async {
  final image = await imageFile.readAsBytes();

  final decodedImage = decodeImage(image);

  return rects.map((rect) {
    final faceX = rect.topLeft.dx;
    final faceY = rect.topLeft.dy;
    final faceWidth = rect.width;
    final faceHeight = rect.height;

    final x = faceX < 0 ? 0 : faceX;
    final y = faceY < 0 ? 0 : faceY;
    final width = faceWidth <= decodedImage.width - x
        ? faceWidth
        : decodedImage.width - x;

    final height = faceHeight <= decodedImage.height - y
        ? faceHeight
        : decodedImage.height - y;

    return Rect.fromLTWH(
      x.toDouble(),
      y.toDouble(),
      width.toDouble(),
      height.toDouble(),
    );
  }).toList();
}

Future<Uint8List> getFaceFromImage({
  File imageFile,
  Uint8List imageBytes,
  @required Rect rect,
}) async {
  if (imageFile == null && imageBytes == null) {
    throw NullException();
  }

  final image = imageBytes ?? await imageFile.readAsBytes();
  final decodedImage = decodeImage(image);

  // final faceX = rect.topLeft.dx.toInt();
  // final faceY = rect.topLeft.dy.toInt();
  // final faceWidth = rect.width.toInt();
  // final faceHeight = rect.height.toInt();

  // final x = faceX < 0 ? 0 : faceX;
  // final y = faceY < 0 ? 0 : faceY;
  // final width =
  //     faceWidth <= decodedImage.width - x ? faceWidth : decodedImage.width - x;

  // final height = faceHeight <= decodedImage.height - y
  //     ? faceHeight
  //     : decodedImage.height - y;

  try {
    // final face = copyCrop(decodedImage, x, y, width, height);
    final face = copyCrop(
      decodedImage,
      rect.topLeft.dx.toInt(),
      rect.topLeft.dy.toInt(),
      rect.width.toInt(),
      rect.height.toInt(),
    );

    return Uint8List.fromList(encodePng(face));
  } on RangeError {
    return null;
  }
}

class NullException implements Exception {}
