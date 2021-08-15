import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import '../models/trip_model.dart';

class PastTripsBox {
  static void addPastTripToBox(Trip trip) {
    final Box<Trip> _pasrTripsBox = Hive.box('past_trips');
    _pasrTripsBox.add(trip);
  }

  static void modifyPastTripInBox(Trip trip) {
    trip.save();
  }

  static void deletePastTripFromBox(Trip trip) {
    trip.delete();
  }
}
