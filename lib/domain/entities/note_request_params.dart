import 'package:equatable/equatable.dart';

class NoteRequestParams extends Equatable {
  final String? name;
  final int? id;
  final String? title;

  const NoteRequestParams({this.name, this.id, this.title});

  @override
  List<Object?> get props => [id, name];

  @override
  bool get stringify => true;
}
