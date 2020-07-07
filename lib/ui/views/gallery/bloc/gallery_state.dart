part of 'gallery_bloc.dart';

@immutable
abstract class GalleryState {}

class GalleryInitial extends GalleryState {}

class Loading extends GalleryState {}

class Loaded extends GalleryState {
  final List<AppImageData> appImagesData;
  final List<CustromPoster> posters;

  Loaded({
    @required this.appImagesData,
    @required this.posters,
  });
}

class AppImageData extends GalleryState {
  final AppImage appImage;
  final Uint8List image;
  final List<FaceAndId> faces;

  AppImageData({
    @required this.appImage,
    @required this.image,
    @required this.faces,
  });
}

class NoDataState extends GalleryState {
  static const thisUser = 'Be the first to upload a picture about your class !';
  static const notThisUser = 'This class hasn\'t posted any picture yet.';

  final String message;

  NoDataState({@required this.message});
}

class CustromPoster {
  final UserProfile poster;
  final String imageUrl;

  CustromPoster({
    @required this.poster,
    @required this.imageUrl,
  });
}
