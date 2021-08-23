import 'package:hive/hive.dart';
import '../trip_models/trip_model.dart';

import '../../constants.dart';
part 'history_model.g.dart';

@HiveType(typeId: 1)
class History extends HiveObject {
  @HiveField(0)
  Trip? trip;
  @HiveField(2)
  TripState? state;
  History({this.trip, this.state});
}

//last used typId is 6