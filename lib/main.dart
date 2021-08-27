import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_sandbox/core/constants/colors.dart';
import 'package:todo_sandbox/presentation/di/di.dart';
import 'package:todo_sandbox/presentation/screens/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Init theme
  await initTheme();
  //Init dependency injection
  await _initDi();

  runApp(const App());
}

Future<void> _initDi() async => await setupDi();

//Future<void> _initFirebase() async => await Firebase.initializeApp();
Future<void> initTheme() async => SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: primaryColor));
