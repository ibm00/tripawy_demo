// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repeat_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepeatingAdapter extends TypeAdapter<Repeating> {
  @override
  final int typeId = 5;

  @override
  Repeating read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Repeating.No;
      case 1:
        return Repeating.Daily;
      case 2:
        return Repeating.Weekly;
      case 3:
        return Repeating.Monthly;
      default:
        return Repeating.No;
    }
  }

  @override
  void write(BinaryWriter writer, Repeating obj) {
    switch (obj) {
      case Repeating.No:
        writer.writeByte(0);
        break;
      case Repeating.Daily:
        writer.writeByte(1);
        break;
      case Repeating.Weekly:
        writer.writeByte(2);
        break;
      case Repeating.Monthly:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepeatingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
