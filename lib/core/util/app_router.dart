import 'package:flutter/material.dart';
import 'package:todo_sandbox/presentation/screens/home/home_screen.dart';

extension AppRouteEx on AppRoute {
  String get value {
    switch (this) {
      case AppRoute.HOME:
        return '/';
      case AppRoute.AUTH:
        return '/auth';
      default:
        throw Exception('No route with name *$this found.');
    }
  }
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case '/home':
      case '/auth':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        throw Exception('No route with name *${settings.name} found.');
    }
  }
}

enum AppRoute {
  HOME,
  AUTH,
}
