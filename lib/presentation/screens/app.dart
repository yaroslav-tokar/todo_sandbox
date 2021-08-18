import 'package:flutter/material.dart';
import 'package:todo_sandbox/config/navigation/navigation.dart';
import 'package:todo_sandbox/config/route/router.dart' as router;
import 'package:todo_sandbox/config/theme/theme.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        initialRoute: router.AppRoute.home.value,
        navigatorKey: Navigation.navigatorKey,
        theme: applicationTheme,
        onGenerateRoute: router.Router.generateRoute,
      );
}
