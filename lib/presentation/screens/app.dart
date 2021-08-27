import 'package:flutter/material.dart';
import 'package:todo_sandbox/config/lifecycle/lifecycle.dart';
import 'package:todo_sandbox/config/navigation/navigation.dart';
import 'package:todo_sandbox/config/route/router.dart' as router;
import 'package:todo_sandbox/config/theme/theme.dart';

class App extends StatefulWidget {
  static final List<ApplicationLifeCycle> _lifeCycleListeners =
      <ApplicationLifeCycle>[];

  static void addLifeCycleListener(ApplicationLifeCycle listener) =>
      _lifeCycleListeners.add(listener);

  static void removeLifeCycleListener(ApplicationLifeCycle listener) =>
      _lifeCycleListeners.remove(listener);

  void onDetach() {
    for (final ApplicationLifeCycle item in _lifeCycleListeners) {
      item.onDetach();
    }
  }

  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

//TODO create AppBloc for managing global all events
class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) => MaterialApp(
        initialRoute: router.AppRoute.home.value,
        navigatorKey: Navigation.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: applicationTheme,
        onGenerateRoute: router.Router.generateRoute,
      );

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        widget.onDetach();
        break;
    }
  }
}
