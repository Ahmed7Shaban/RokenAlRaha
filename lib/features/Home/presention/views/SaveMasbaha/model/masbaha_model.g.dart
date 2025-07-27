// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'masbaha_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasbahaModelAdapter extends TypeAdapter<MasbahaModel> {
  @override
  final int typeId = 0;

  @override
  MasbahaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MasbahaModel(
      title: fields[0] as String,
      count: fields[1] as int,
      date: fields[3] as DateTime,
      duration: Duration(seconds: fields[2] as int),
    );
  }

  @override
  void write(BinaryWriter writer, MasbahaModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.count)
      ..writeByte(2)
      ..write(obj.durationInSeconds)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasbahaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
