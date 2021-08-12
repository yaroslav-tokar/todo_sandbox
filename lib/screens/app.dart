import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_sandbox/constants/colors.dart';
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
        theme: ThemeData(
            primaryColor: primaryColor,
            accentColor: accentColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: GoogleFonts.lato().fontFamily),
        onGenerateRoute: router.Router.generateRoute,
      );
}
