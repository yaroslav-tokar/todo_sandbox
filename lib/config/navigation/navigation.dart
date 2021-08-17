import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_sandbox/config/route/router.dart';

class Nav {
  static final Nav I = Nav._();

  factory Nav() => I;

  Nav._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  BuildContext get navContext => navigatorKey.currentState!.context;

  Future<void> pushNamed(AppRoute appRoute, {Object? args}) async =>
      navigatorKey.currentState!.pushNamed(appRoute.value, arguments: args);
}
