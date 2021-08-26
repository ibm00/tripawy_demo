// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_state_enuum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripStateAdapter extends TypeAdapter<TripState> {
  @override
  final int typeId = 7;

  @override
  TripState read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TripState.Done;
      case 1:
        return TripState.Cancelled;
      default:
        return TripState.Done;
    }
  }

  @override
  void write(BinaryWriter writer, TripState obj) {
    switch (obj) {
      case TripState.Done:
        writer.writeByte(0);
        break;
      case TripState.Cancelled:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
