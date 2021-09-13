import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:tripawy_demo/constants.dart';
import 'package:tripawy_demo/database/history_box.dart';
import 'package:tripawy_demo/models/history_models/history_model.dart';
import 'package:tripawy_demo/notifications/notifications.dart';
import 'package:tripawy_demo/providers/history_provider.dart';
import '../models/exceptions_models/plus_ten_exception.dart';
import '../database/upcoming_trips_box.dart';
import '../models/trip_models/trip_model.dart';

final upcommingTripsProv =
    ChangeNotifierProvider((ref) => _UpcommingTripsProv(ref));

class _UpcommingTripsProv extends ChangeNotifier {
  final ProviderReference _reference;
  _UpcommingTripsProv(this._reference);

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
    // List<Trip> allTrips = await UpcommingTripsBox.tripsInTheBox;
    // List<Trip> endedTrips = allTrips
    //     .where((trip) => trip.startDate!.isBefore(DateTime.now()))
    //     .toList()
    //     .cast<Trip>();

    // endedTrips.forEach((pastTrip) {
    //   _reference
    //       .read(historyProv)
    //       .addPastTrip(History(trip: pastTrip, state: TripState.Done));
    //   allTrips.remove(pastTrip);
    //   UpcommingTripsBox.deleteTripFromBox(pastTrip);
    // });
    // _trips = allTrips;
    _checkForPastTrips();
    notifyListeners();
  }

  void _checkForPastTrips() {
    List<Trip> endedTrips = _trips
        .where((trip) => trip.startDate!.isBefore(DateTime.now()))
        .toList()
        .cast<Trip>();
    // print('trips length: ${_trips.length}');
    // print('trips date: ${_trips[0].startDate}');
    // print(_trips[0].startDate!.isBefore(DateTime.now()));
    // print('endeeeeeeeed: ${endedTrips.length}');
    endedTrips.forEach((endedTrip) async {
      await moveTheTripToHistory(endedTrip, true);
    });
  }

  List<Trip> get upcommingTrips {
    return [..._trips];
  }

  Trip getTrip(int key) {
    return _trips.firstWhere((element) => element.key == key);
  }

  void addTrip(Trip trip) {
    try {
      UpcommingTripsBox.addTripToBox(trip);
      _trips.insert(0, trip);
      notifyListeners();
      Notifications.creatSchedualNotification(
        id: trip.key,
        tripDateAndTime: trip.startDate,
        tripName: trip.name,
      );
      // trip.timer = Timer(
      //   Duration(seconds: trip.startDate!.difference(DateTime.now()).inSeconds),
      //  ()=> _moveTheTripToHistory(trip,TripState.Done),
      // );
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
      _trips[index] = oldTrip;
      notifyListeners();
      print('iddddddddd: ${oldTrip.key}');
      Notifications.modifySchedualedNotification(
        id: oldTrip.key,
        newTripDateAndTime: oldTrip.startDate,
        tripName: oldTrip.name,
      );
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
      final index = _trips.indexWhere((tr) => tr.key == trip.key);
      _trips.removeAt(index);
      UpcommingTripsBox.deleteTripFromBox(trip);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  String? getTripName(int key) {
    return _trips.firstWhere((trip) => trip.key == key).name ?? "";
  }

  List? getTripNotes(int key) {
    return _trips.firstWhere((trip) => trip.key == key).notes ?? [];
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

  Future<void> moveTheTripToHistory(Trip trip, bool _isTripDone) async {
    try {
      if (!Hive.isBoxOpen('past_trips')) {
        await Hive.openBox<History>('past_trips');
      }
      deleteTrip(trip);
      HistoryBox.addPastTripToBox(History(trip: trip, isTripDone: _isTripDone));
      await _reference.read(historyProv).fetchPastTrips();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
