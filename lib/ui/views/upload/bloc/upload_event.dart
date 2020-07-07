part of 'upload_bloc.dart';

@immutable
abstract class UploadEvent {}

class PrepareImageEvent extends UploadEvent {
  final File imageFile;

  PrepareImageEvent({
    @required this.imageFile,
  });
}

class SetTitleEvent extends UploadEvent {
  final String title;

  SetTitleEvent({@required this.title});
}

class SetUserNameEvent extends UploadEvent {
  final FaceAndId faceAndId;
  final String name;

  SetUserNameEvent({@required this.faceAndId, @required this.name});
}

class UploadImageEvent extends UploadEvent {}

class UploadFinishedEvent extends UploadImageEvent {
  final String imagePath;

  UploadFinishedEvent({@required this.imagePath});
}
