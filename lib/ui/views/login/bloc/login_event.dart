part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginWithGoogleEvent extends LoginEvent {}

class SaveUserProfileEvent extends LoginEvent {
  final PromoField promoField;
  final int year;
  final Site site;
  final String userName;

  SaveUserProfileEvent({
    @required this.promoField,
    @required this.year,
    @required this.site,
    @required this.userName,
  });
}

class PickImageEvent extends LoginEvent {}
