import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_router.dart';

class Nav {
  static final navigatorKey = GlobalKey<NavigatorState>();

  BuildContext get navContext => navigatorKey.currentState!.context;

  Future<void> pushNamed(AppRoute appRoute, Object args) async =>
      navigatorKey.currentState!.pushNamed(appRoute.value, arguments: args);
}
