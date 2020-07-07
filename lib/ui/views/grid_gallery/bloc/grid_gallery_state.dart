part of 'grid_gallery_bloc.dart';

@immutable
abstract class GridGalleryState {}

class GridGalleryInitial extends GridGalleryState {}

class GridGalleryLoaded extends GridGalleryState {
  final List<MajorYears> majorYearsList;

  GridGalleryLoaded({
    @required this.majorYearsList,
  });
}

class GridGalleryMajorYears extends GridGalleryState {
  final MajorYears majorYears;

  GridGalleryMajorYears({
    @required this.majorYears,
  });
}

class EmptyGridGalleryState extends GridGalleryState {
  final String message;

  EmptyGridGalleryState({@required this.message});
}
