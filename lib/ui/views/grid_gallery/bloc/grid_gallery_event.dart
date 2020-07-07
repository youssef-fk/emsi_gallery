part of 'grid_gallery_bloc.dart';

@immutable
abstract class GridGalleryEvent {}

class LoadGridGalleryEvent extends GridGalleryEvent {
  final String siteName;

  LoadGridGalleryEvent({@required this.siteName});
}

class MajorYearsGridGalleryEvent extends GridGalleryEvent {
  final MajorYears majorYears;

  MajorYearsGridGalleryEvent({@required this.majorYears});
}

class GoBackFromYearsEvent extends GridGalleryEvent {}

class NavigateToGalleryEvent extends GridGalleryEvent {
  final int year;
  final String majorName;

  NavigateToGalleryEvent({
    @required this.year,
    @required this.majorName,
  });
}
