import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';

import '../../global/extensions/face_extension.dart';
import 'models/face_and_id.dart';

abstract class GalleryFaceDetectorService {
  Future<List<Face>> getFacesFromImage(File imageFile);
  Future<bool> containsFace(File imageFile);
  Future<List<FaceAndId>> extractFaces(File imageFile);
  // Future<List<FaceAndId>> extractFacesFromBytes(Uint8List imageBytes);
  // static Future<Uint8List> downloadImage(String url);
}

class GalleryFaceDetectorServiceImpl implements GalleryFaceDetectorService {
  final _firebaseVision = FirebaseVision.instance;

  // Future<File> _getTemporaryFileFromBytes(Uint8List bytes) async {
  //   final directory = await getTemporaryDirectory();

  //   final file = await File(
  //     '${directory.path}/images/${DateTime.now().toIso8601String()}',
  //   ).create(recursive: true);

  //   return await file.writeAsBytes(bytes);
  // }

  @override
  Future<List<Face>> getFacesFromImage(File imageFile) async {
    final image = FirebaseVisionImage.fromFile(imageFile);

    final faceDetector = _firebaseVision.faceDetector(FaceDetectorOptions(
      mode: FaceDetectorMode.fast,
      enableTracking: true,
    ));

    final faces = await faceDetector.processImage(image);

    // faces[0].getContour(FaceContourType.face).positionsList.
    faceDetector.close();
    return faces;
  }

  @override
  Future<bool> containsFace(File imageFile) async {
    final faces = await getFacesFromImage(imageFile);

    return faces.length == 1;
  }

  @override
  Future<List<FaceAndId>> extractFaces(File imageFile) async {
    final faces = await this.getFacesFromImage(imageFile);

    final faceAndIds = <FaceAndId>[];

    final rects = await formatRects(
        imageFile: imageFile, rects: faces.map((e) => e.boundingBox).toList());

    for (final face in faces) {
      final index = faces.indexOf(face);
      final faceAndId = FaceAndId(
        await getFaceFromImage(
          imageFile: imageFile,
          rect: rects.elementAt(index),
        ),
        face.trackingId,
        rects.elementAt(index),
      );

      if (faceAndId.faceData != null) {
        faceAndIds.add(faceAndId);
      }
    }
    return faceAndIds;
  }
}
