// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'way_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WayAdapter extends TypeAdapter<Way> {
  @override
  final int typeId = 4;

  @override
  Way read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Way.OneWay;
      case 1:
        return Way.Round;
      default:
        return Way.OneWay;
    }
  }

  @override
  void write(BinaryWriter writer, Way obj) {
    switch (obj) {
      case Way.OneWay:
        writer.writeByte(0);
        break;
      case Way.Round:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
