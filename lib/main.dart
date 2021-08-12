import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:todo_sandbox/core/model/dbo/note_dbo.dart';
import 'package:todo_sandbox/di/di.dart';
import 'package:todo_sandbox/screens/app.dart';
import 'package:todo_sandbox/util/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Init Hive db
  await _initHive();
  //Init dependency injection
  await _initDi();

  runApp(App());
}

Future<void> _initHive() async {
  try {
    final Directory? directory =
        await pathProvider.getApplicationDocumentsDirectory();
    if (directory != null) {
      Hive.init(directory.path);
      Hive.registerAdapter(NoteDboAdapter());
    }
  } catch (e) {
    Logger.e('Cant init Hive, cause\t$e');
  }
}

Future<void> _initDi() async => await setupDi();

//Future<void> _initFirebase() async => await Firebase.initializeApp();
