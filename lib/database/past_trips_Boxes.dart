import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import 'package:tripawy_demo/models/history_model.dart';

class PastTripsBox {
  static void addPastTripToBox(History pastTrip) {
    final Box<History> _pasrTripsBox = Hive.box('past_trips');
    _pasrTripsBox.add(pastTrip);
  }

  static void deletePastTripFromBox(History pastTrip) {
    pastTrip.delete();
  }
}
