import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../services/auth/auth_service.dart';
import '../../../../services/navigation/navigation_service.dart';
import '../../gallery/gallery_view.dart';
import '../../login/login_view.dart';

part 'startup_event.dart';
part 'startup_state.dart';

class StartupBloc extends Bloc<StartupEvent, StartupState> {
  final AuthService authService;
  final NavigationService navigationService;

  StartupBloc({
    @required this.authService,
    @required this.navigationService,
  });

  @override
  StartupState get initialState => StartupInitial();

  @override
  Stream<StartupState> mapEventToState(
    StartupEvent event,
  ) async* {
    if (event is HandleLogin) {
      if (await authService.isLoggedIn) {
        final userProfile = await authService.userProfile;
        navigationService.replace(
          GalleryView.routeName,
          args: GalleryArguments(
            site: userProfile.site,
            expectedGraduationYear: userProfile.expectedGraduationYear,
            promoField: userProfile.promo.promoField,
          ),
        );
      } else {
        navigationService.replace(LoginView.routeName);
      }
    }
  }
}
