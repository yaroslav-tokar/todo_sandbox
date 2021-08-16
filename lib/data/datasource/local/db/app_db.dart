import 'package:floor/floor.dart';
import 'package:todo_sandbox/data/datasource/local/dao/note_dao.dart';
import 'package:todo_sandbox/data/datasource/local/dbo/note_dbo.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'app_db.g.dart';


@Database(version: 1, entities: [NoteDbo])
abstract class AppDatabase extends FloorDatabase {
  NoteDao get noteDao;
}
