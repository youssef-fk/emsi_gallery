part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class MoreInfo extends LoginState {
  final List<City> cities;
  final File userImage;
  final bool hasFace;

  MoreInfo({
    @required this.cities,
    @required this.userImage,
    @required this.hasFace,
  });
}

class Loading extends LoginState {}

class LoginError extends LoginState {}
