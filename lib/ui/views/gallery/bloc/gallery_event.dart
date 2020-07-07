part of 'gallery_bloc.dart';

@immutable
abstract class GalleryEvent {}

class NavigateToMapEvent extends GalleryEvent {}

class LoadAppImagesEvent extends GalleryEvent {
  final GalleryArguments galleryArguments;

  LoadAppImagesEvent({@required this.galleryArguments});
}

class AppImageSnapshotEvent extends GalleryEvent {
  final QuerySnapshot snapshot;

  AppImageSnapshotEvent({@required this.snapshot});
}

class PickImageEvent extends GalleryEvent {}

class PickFromGalleryEvent extends PickImageEvent {}

class PickFromCameraEvent extends PickImageEvent {}

class OnPressGridEvent extends GalleryEvent {
  final String siteName;

  OnPressGridEvent({@required this.siteName});
}
