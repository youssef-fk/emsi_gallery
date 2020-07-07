import 'package:flutter/cupertino.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> push(String routeName, {Object args}) {
    return navigatorKey.currentState.pushNamed(
      routeName,
      arguments: args,
    );
  }

  Future<void> replace(String routeName, {Object args}) {
    return navigatorKey.currentState.pushReplacementNamed(
      routeName,
      arguments: args,
    );
  }

  void pop() {
    navigatorKey.currentState.pop();
  }
}
