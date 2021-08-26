// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryAdapter extends TypeAdapter<History> {
  @override
  final int typeId = 1;

  @override
  History read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return History(
      trip: fields[0] as Trip?,
      isTripDone: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, History obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.trip)
      ..writeByte(3)
      ..write(obj.isTripDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
