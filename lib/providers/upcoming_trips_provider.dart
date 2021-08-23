import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/exceptions_models/plus_ten_exception.dart';
import '../database/upcoming_trips_box.dart';
import '../models/trip_models/trip_model.dart';

final upcommingTripsProv =
    ChangeNotifierProvider((ref) => _UpcommingTripsProv());

class _UpcommingTripsProv extends ChangeNotifier {
  List<Trip> _trips = [
    // Trip(
    //   endPoint: "Alex",
    //   name: 'Alex',
    //   repeating: Repeating.Daily,
    //   startDate: DateTime.now(),
    //   startPoint: "Cairo",
    //   way: Way.Round,
    // ),
    // Trip(
    //   endPoint: "Alex",
    //   name: 'Alex',
    //   repeating: Repeating.Daily,
    //   startDate: DateTime.now(),
    //   startPoint: "Cairo",
    //   way: Way.Round,
    // ),
    // Trip(
    //   endPoint: "Alex",
    //   name: 'Alex',
    //   repeating: Repeating.Daily,
    //   startDate: DateTime.now(),
    //   startPoint: "Cairo",
    //   way: Way.Round,
    // ),
    // Trip(
    //   endPoint: "Alex",
    //   name: 'Alex',
    //   repeating: Repeating.Daily,
    //   startDate: DateTime.now(),
    //   startPoint: "Cairo",
    //   way: Way.Round,
    // ),
  ];

  Future<void> fetchTrips() async {
    _trips = await UpcommingTripsBox.tripsInTheBox;
  }

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

  void modifyTrip(Trip modifiedTrip, Trip oldTrip) {
    if (!oldTrip.isInBox) {
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

  String? getTripName(int key) {
    return _trips.firstWhere((trip) => trip.key == key).name ?? "";
  }

  List<String?>? getTripNotes(int key) {
    return _trips.firstWhere((trip) => trip.key == key).notes
            as List<String?>? ??
        [];
  }

  void addTripNote(String note, int key) {
    final oldTrip = _trips.firstWhere((trip) => trip.key == key);
    if (oldTrip.notes!.length >= 10)
      throw PlusTenException('Ten notes is enough, fu** you!');
    try {
      oldTrip.notes!.insert(0, note);
      UpcommingTripsBox.updateNotesInTheBox(oldTrip);
      notifyListeners();
    } catch (e) {
      oldTrip.notes!.removeAt(0);
      print(e);
      throw e;
    }
  }

  void modifyTripNote(String note, int key, int index) {
    final oldTrip = _trips.firstWhere((trip) => trip.key == key);
    try {
      oldTrip.notes![index] = note;
      UpcommingTripsBox.updateNotesInTheBox(oldTrip);
      notifyListeners();
    } catch (e) {
      oldTrip.notes!.removeAt(index);
      print(e);
      throw e;
    }
  }

  void deleteTripNote(int key, int index) {
    final oldTrip = _trips.firstWhere((trip) => trip.key == key);
    final String? deletedNote = oldTrip.notes![index];
    try {
      oldTrip.notes!.removeAt(index);
      UpcommingTripsBox.updateNotesInTheBox(oldTrip);
      notifyListeners();
    } catch (e) {
      oldTrip.notes!.insert(index, deletedNote);
      print(e);
      throw e;
    }
  }
}
