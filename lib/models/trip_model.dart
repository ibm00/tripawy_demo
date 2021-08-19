import 'package:hive/hive.dart';
import 'package:tripawy_demo/models/repeat_enum.dart';
import 'package:tripawy_demo/models/way_enum.dart';

import '../constants.dart';
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
  List<String?>? notes = [];
  Trip({
    required this.endPoint,
    required this.name,
    required this.repeating,
    required this.startDate,
    required this.startPoint,
    required this.way,
    this.notes,
  });
}

//used typId{0}