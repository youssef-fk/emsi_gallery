part of 'upload_bloc.dart';

@immutable
abstract class UploadState {}

class UploadInitial extends UploadState {}

class Loading extends UploadState {}

class Loaded extends UploadState {
  final ui.Image image;
  final List<FaceAndId> faceAndIds;
  final RectPainter facePainter;
  final List<CustromPoster> profiles;

  Loaded({
    @required this.image,
    @required this.faceAndIds,
    @required this.facePainter,
    @required this.profiles,
  });
}

class UploadingImage extends Loaded {
  final Stream<StorageTaskEvent> uploadStream;

  UploadingImage({
    @required this.uploadStream,
    @required Loaded state,
  }) : super(
          faceAndIds: state.faceAndIds,
          image: state.image,
          facePainter: state.facePainter,
          profiles: state.profiles,
        );
}

class Aborted extends UploadState {}
