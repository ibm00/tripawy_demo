import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tripawy_demo/models/repeat_enum.dart';
import 'package:tripawy_demo/models/way_enum.dart';
import '../database/upcomming_trips_Boxes.dart';
import '../models/trip_model.dart';

final upcommingTripsProv =
    ChangeNotifierProvider((ref) => _UpcommingTripsProv());

class _UpcommingTripsProv extends ChangeNotifier {
  List<Trip> _trips = [
    Trip(
      endPoint: "Alex",
      name: 'Alex',
      repeating: Repeating.Daily,
      startDate: DateTime.now(),
      startPoint: "Cairo",
      way: Way.Round,
    ),
    Trip(
      endPoint: "Alex",
      name: 'Alex',
      repeating: Repeating.Daily,
      startDate: DateTime.now(),
      startPoint: "Cairo",
      way: Way.Round,
    ),
    Trip(
      endPoint: "Alex",
      name: 'Alex',
      repeating: Repeating.Daily,
      startDate: DateTime.now(),
      startPoint: "Cairo",
      way: Way.Round,
    ),
    Trip(
      endPoint: "Alex",
      name: 'Alex',
      repeating: Repeating.Daily,
      startDate: DateTime.now(),
      startPoint: "Cairo",
      way: Way.Round,
    ),
  ];

  void fetchTrips() {
    final Box<Trip> _tripsBox = Hive.box('upcomming_trips');
    _trips = _tripsBox.values.toList().cast<Trip>();
  }

  List<Trip> get upcommingTrips {
    return [..._trips];
  }

  void addTrip(Trip trip) {
    try {
      UpcommingTripsBox.addTripToBox(trip);
      _trips.insert(0, trip);
      notifyListeners();
      print("notifyed");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void modifyTrip(Trip modifiedTrip, Trip oldTrip) {
    if (!oldTrip.isInBox) {
      print('this element is not in the box');
      throw 'this element is not in the box';
    }
    try {
      print("passed return");
      UpcommingTripsBox.modifyTripInBox(modifiedTrip, oldTrip);
      final index = _trips.indexWhere((tr) => tr.key == oldTrip.key);
      _trips[index] = modifiedTrip;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void deleteTrip(Trip trip) {
    if (!trip.isInBox) {
      print('this element is not in the box');
      throw 'this element is not in the box';
    }
    try {
      UpcommingTripsBox.deleteTripFromBox(trip);
      final index = _trips.indexWhere((tr) => tr.key == trip.key);
      _trips.removeAt(index);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
