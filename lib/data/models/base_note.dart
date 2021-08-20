import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

class BaseNote extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'title')
  final String title;
  @ColumnInfo(name: 'content')
  final String content;
  @ColumnInfo(name: 'created_at')
  final int createAt;
  @ColumnInfo(name: 'updated_at')
  final int updateAt;

  const BaseNote({
    this.id,
    required this.title,
    required this.content,
    required this.createAt,
    required this.updateAt,
  });

  @override
  List<Object?> get props => <Object>[id!];

  @override
  bool get stringify => true;
}
