import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/upcomming_trips_Boxes.dart';
import '../models/trip_model.dart';

final upcommingTripsProv =
    ChangeNotifierProvider((ref) => _UpcommingTripsProv());

class _UpcommingTripsProv extends ChangeNotifier {
  List<Trip> _trips = [];

  List<Trip> get upcommingTrips {
    return [..._trips];
  }

  void addTrip(Trip trip) {
    try {
      UpcommingTripsBox.addTripToBox(trip);
      _trips.insert(0, trip);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void modifyTrip(Trip trip) {
    if (trip.key == null) {
      print('this element is not in the box');
      return;
    }
    try {
      UpcommingTripsBox.modifyTripInBox(trip);
      final index = _trips.indexWhere((tr) => tr.key == trip.key);
      _trips.insert(index, trip);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void deleteTrip(Trip trip) {
    if (trip.key == null) {
      print('this element is not in the box');
      return;
    }
    try {
      UpcommingTripsBox.deleteTripFromBox(trip);
      final index = _trips.indexWhere((tr) => tr.key == trip.key);
      _trips.removeAt(index);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
