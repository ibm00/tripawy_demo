import 'package:hive_flutter/hive_flutter.dart';

part 'trip_state_enum.g.dart';

@HiveType(typeId: 6)
enum TripState {
  @HiveField(0)
  Done,

  @HiveField(1)
  Cancelled,
}

//last used typId is 6
