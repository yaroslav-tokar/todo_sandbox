import 'package:flutter/material.dart';
import 'package:todo_sandbox/core/util/logger.dart';
import 'package:todo_sandbox/presentation/di/di.dart';
import 'package:todo_sandbox/presentation/screens/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Init Hive db
  await _initDb();
  //Init dependency injection
  await _initDi();

  runApp(const App());
}

Future<void> _initDb() async {
  try {} catch (e) {
    logError('Cant init Hive, cause\t$e');
  }
}

Future<void> _initDi() async => await setupDi();

//Future<void> _initFirebase() async => await Firebase.initializeApp();
