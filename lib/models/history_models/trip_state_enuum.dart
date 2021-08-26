import 'package:hive_flutter/hive_flutter.dart';

part 'trip_state_enuum.g.dart';

@HiveType(typeId: 7)
enum TripState {
  @HiveField(0)
  Done,

  @HiveField(1)
  Cancelled,
}

//last used typId is 7
