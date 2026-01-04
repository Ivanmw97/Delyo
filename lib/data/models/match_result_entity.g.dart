// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_result_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatchResultEntityAdapter extends TypeAdapter<MatchResultEntity> {
  @override
  final int typeId = 2;

  @override
  MatchResultEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatchResultEntity(sets: (fields[0] as List).cast<PadelSetEntity>());
  }

  @override
  void write(BinaryWriter writer, MatchResultEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.sets);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchResultEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
