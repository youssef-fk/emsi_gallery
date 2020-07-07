import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../services/auth/auth_service.dart';
import '../../../../services/auth/models/promo/promo.dart';
import '../../../../services/grid_gallery/grid_gallery_service.dart';
import '../../../../services/grid_gallery/models/major_years/major_years.dart';
import '../../../../services/map/map_service.dart';
import '../../../../services/navigation/navigation_service.dart';
import '../../gallery/gallery_view.dart';

part 'grid_gallery_event.dart';
part 'grid_gallery_state.dart';

class GridGalleryBloc extends Bloc<GridGalleryEvent, GridGalleryState> {
  final AuthService authService;
  final GridGalleryService gridGalleryService;
  final NavigationService navigationService;
  final MapService mapService;

  GridGalleryBloc({
    @required this.authService,
    @required this.gridGalleryService,
    @required this.navigationService,
    @required this.mapService,
  });

  @override
  GridGalleryState get initialState => GridGalleryInitial();

  String selectedSiteName;
  List<MajorYears> majorYearsList;

  @override
  Stream<GridGalleryState> mapEventToState(
    GridGalleryEvent event,
  ) async* {
    if (event is LoadGridGalleryEvent) {
      this.selectedSiteName = event.siteName;

      this.majorYearsList =
          await gridGalleryService.getMajorYearsList(siteName: this.selectedSiteName);

      yield majorYearsList.isEmpty
          ? EmptyGridGalleryState(
              message: 'Nothing to see yet.',
            )
          : GridGalleryLoaded(
              majorYearsList: this.majorYearsList,
            );
    }

    if (event is MajorYearsGridGalleryEvent) {
      yield GridGalleryMajorYears(majorYears: event.majorYears);
    }

    if (event is GoBackFromYearsEvent) {
      yield GridGalleryLoaded(
        majorYearsList: this.majorYearsList,
      );
    }

    if (event is NavigateToGalleryEvent) {
      final promoField = PromoField.values.singleWhere(
        (element) => element.value == event.majorName,
        orElse: () => null,
      );

      final cities = await mapService.cities;

      final site = cities
          .map((city) {
            final res = city.sites
                .map(
                  (e) => e.name == this.selectedSiteName ? e : null,
                )
                .where(
                  (element) => element != null,
                );

            return res.isNotEmpty ? res.single : null;
          })
          .where((element) => element != null)
          .single;

      navigationService.push(
        GalleryView.routeName,
        args: GalleryArguments(
          expectedGraduationYear: event.year,
          promoField: promoField,
          site: site,
        ),
      );
    }
  }
}
