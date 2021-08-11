import 'package:flutter/material.dart';
import 'package:todo_sandbox/util/navigation.dart';
import 'package:todo_sandbox/util/app_router.dart' as router;

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        initialRoute: router.AppRoute.HOME.value,
        navigatorKey: Nav.navigatorKey,
        onGenerateRoute: router.Router.generateRoute,
      );
}
