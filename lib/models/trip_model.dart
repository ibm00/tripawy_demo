import 'package:hive/hive.dart';

import '../constants.dart';
part 'trip_model.g.dart';

@HiveType(typeId: 0)
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
  Trip({
    required this.endPoint,
    required this.name,
    required this.repeating,
    required this.startDate,
    required this.startPoint,
    required this.way,
  });
}
