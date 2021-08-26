import 'dart:async';

import 'package:hive/hive.dart';
import 'repeat_enum.dart';
import 'way_enum.dart';

part 'trip_model.g.dart';

@HiveType(typeId: 2)
class Trip extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? startPoint;
  @HiveField(2)
  String? endPoint;
  @HiveField(3)
  DateTime? startDate;
  @HiveField(4)
  Repeating? repeating;
  @HiveField(5)
  Way? way;
  @HiveField(6)
  List? notes = [];
  @HiveField(7)
  // Timer? timer;
  Trip({
    required this.endPoint,
    required this.name,
    required this.repeating,
    required this.startDate,
    required this.startPoint,
    required this.way,
    List<String?>? notes,
    // timer,
  }) : this.notes = notes ?? [];
}

//used typId{0}
//last used typId is 6