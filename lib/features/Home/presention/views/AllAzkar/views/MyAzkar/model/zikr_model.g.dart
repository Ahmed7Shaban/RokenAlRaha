// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zikr_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ZikrModelAdapter extends TypeAdapter<ZikrModel> {
  @override
  final int typeId = 1;

  @override
  ZikrModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ZikrModel(
      title: fields[0] as String,
      content: fields[1] as String,
      count: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ZikrModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZikrModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
