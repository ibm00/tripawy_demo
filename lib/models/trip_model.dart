import '../constants.dart';

class Trip {
  String? name;
  String? startPoint;
  String? endPoint;
  DateTime? startDate;
  Repeating? repeating;
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
