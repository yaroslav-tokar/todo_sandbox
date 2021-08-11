// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_dbo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteDboAdapter extends TypeAdapter<NoteDbo> {
  @override
  final int typeId = 0;

  @override
  NoteDbo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteDbo(
      category: fields[0] as NoteCategory?,
      id: fields[1] as dynamic,
      title: fields[2] as dynamic,
      content: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, NoteDbo obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteDboAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
