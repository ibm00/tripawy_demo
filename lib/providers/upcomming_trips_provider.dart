import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/upcomming_trips_Boxes.dart';
import '../models/trip_model.dart';

final upcommingTripsProv =
    ChangeNotifierProvider((ref) => _UpcommingTripsProv());

class _UpcommingTripsProv extends ChangeNotifier {
  List<Trip> _trips = [];

  void addTrip(Trip trip) {
    _trips.add(trip);
    UpcommingTripsBox.addTripToBox(trip);
    notifyListeners();
  }
}
