import 'package:hive/hive.dart';
import '../trip_models/trip_model.dart';

import '../../constants.dart';
part 'history_model.g.dart';

@HiveType(typeId: 1)
class History extends HiveObject {
  @HiveField(0)
  Trip? trip;
  @HiveField(3)
  bool? isTripDone;
  History({this.trip, this.isTripDone});
}

//last used typId is 6