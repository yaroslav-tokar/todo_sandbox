import 'package:hive/hive.dart';

class BaseNote {
  @HiveField(1)
  String? id;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? content;

  BaseNote(this.id, this.title, this.content);
}
