import 'package:flutter/material.dart';
import 'package:todo_sandbox/presentation/screens/home/home_screen.dart';
import 'package:todo_sandbox/presentation/screens/note/note_details_screen.dart';

extension AppRouteEx on AppRoute {
  String get value {
    switch (this) {
      case AppRoute.noteDetails:
        return '/note_details';
      case AppRoute.home:
        return '/';
      case AppRoute.auth:
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
        return MaterialPageRoute(
            settings: settings, builder: (BuildContext context) => const HomeScreen());
      case '/note_details':
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) => const NoteDetailsScreen());
      default:
        throw Exception('No route with name *${settings.name} found.');
    }
  }
}

enum AppRoute { home, auth, noteDetails }
