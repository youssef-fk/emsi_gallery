import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

import '../auth/models/user_profile/user_profile.dart';

abstract class GalleryFirebaseStorage {
  Stream<StorageTaskEvent> saveImage({
    @required File image,
    @required UserProfile userProfile,
  });

  StorageUploadTask saveImageProfile({
    @required File image,
    @required UserProfile userProfile,
  });

  Future<void> removeImage({
    @required File image,
    @required UserProfile userProfile,
  });

  Future<String> getImageUrl({@required String path});
}

class GalleryFirebaseStorageImpl implements GalleryFirebaseStorage {
  final _storage = FirebaseStorage(
    storageBucket: 'gs://emsi-gallery.appspot.com',
  );

  String _buildImagePath(UserProfile user) {
    return 'images/gallery/${user.site.name}/${user.expectedGraduationYear}/${DateTime.now().toIso8601String()}';
  }

  String _buildImageProfilePath(UserProfile user) {
    return 'images/profiles/${user.site.name}/${user.expectedGraduationYear}/${user.uuid}';
  }

  @override
  Stream<StorageTaskEvent> saveImage({
    @required File image,
    @required UserProfile userProfile,
  }) {
    final imageRef = _storage.ref().child(_buildImagePath(userProfile));

    final task = imageRef.putFile(image);

    return task.events;
  }

  @override
  Future<void> removeImage({File image, UserProfile userProfile}) async {
    final imageRef = _storage.ref().child(_buildImagePath(userProfile));

    imageRef.delete();
  }

  @override
  Future<String> getImageUrl({@required String path}) async {
    return (await _storage.ref().child(path).getDownloadURL()) as String;
  }

  @override
  StorageUploadTask saveImageProfile({
    File image,
    UserProfile userProfile,
  }) {
    final path = _buildImageProfilePath(userProfile);
    final imageRef = _storage.ref().child(path);

    final task = imageRef.putFile(image);

    return task;
  }
}
