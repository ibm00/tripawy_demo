import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import '../models/trip_model.dart';

class UpcommingTripsBox {
  static void addTripToBox(Trip trip) {
    final Box<Trip> _tripsBox = Hive.box('upcomming_trips');
    _tripsBox.add(trip);
  }

  static void modifyTripInBox(Trip trip) {
    trip.save();
  }

  static void deleteTripFromBox(Trip trip) {
    trip.delete();
  }
}
