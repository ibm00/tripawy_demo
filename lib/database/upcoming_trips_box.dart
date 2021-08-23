import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import '../models/trip_models/trip_model.dart';

class UpcommingTripsBox {
  static Future<List<Trip>> get tripsInTheBox async {
    final _tripsBox = await Hive.openBox<Trip>(
      'upcomming_trips',
      compactionStrategy: (entries, deletedEntries) => deletedEntries > 20,
    );
    return _tripsBox.values.toList().reversed.toList().cast<Trip>();
  }

  static void addTripToBox(Trip trip) {
    final Box<Trip> _tripsBox = Hive.box('upcomming_trips');
    _tripsBox.add(trip);
  }

  static void modifyTripInBox(Trip modifiedTrip, Trip oldTrip) {
    oldTrip.name = modifiedTrip.name;
    oldTrip.startPoint = modifiedTrip.startPoint;
    oldTrip.endPoint = modifiedTrip.endPoint;
    oldTrip.startDate = modifiedTrip.startDate;
    oldTrip.save();
  }

  static void deleteTripFromBox(Trip trip) {
    trip.delete();
  }

  static updateNotesInTheBox(Trip oldTrip) {
    oldTrip.save();
  }
}
