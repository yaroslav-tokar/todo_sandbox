import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_sandbox/config/route/router.dart';

class Navigation {
  static final Navigation I = Navigation._();

  factory Navigation() => I;

  Navigation._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  BuildContext get navContext => navigatorKey.currentState!.context;

  Future<void> pushNamed(AppRoute appRoute, {Object? args}) async =>
      navigatorKey.currentState!.pushNamed(appRoute.value, arguments: args);

  Future<void> pop() async => navigatorKey.currentState?.pop();
}
