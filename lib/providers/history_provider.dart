import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripawy_demo/constants.dart';
import 'package:tripawy_demo/models/trip_models/repeat_enum.dart';
import 'package:tripawy_demo/models/trip_models/trip_model.dart';
import 'package:tripawy_demo/models/trip_models/way_enum.dart';
import '../database/history_box.dart';
import '../models/history_models/history_model.dart';

final historyProv = ChangeNotifierProvider((ref) => _HistoryProvider());

class _HistoryProvider extends ChangeNotifier {
  List<History> _pastTrips = [
    History(
      trip: Trip(
        endPoint: "Alex",
        name: 'Alex',
        repeating: Repeating.Daily,
        startDate: DateTime.now(),
        startPoint: "Cairo",
        way: Way.Round,
      ),
      state: TripState.Cancelled,
    ),
    History(
      trip: Trip(
        endPoint: "Alex",
        name: 'Alex',
        repeating: Repeating.Daily,
        startDate: DateTime.now(),
        startPoint: "Cairo",
        way: Way.Round,
      ),
      state: TripState.Done,
    ),
    History(
      trip: Trip(
        endPoint: "Alex",
        name: 'Alex',
        repeating: Repeating.Daily,
        startDate: DateTime.now(),
        startPoint: "Cairo",
        way: Way.Round,
      ),
      state: TripState.Cancelled,
    ),
    History(
      trip: Trip(
        endPoint: "Alex",
        name: 'Alex',
        repeating: Repeating.Daily,
        startDate: DateTime.now(),
        startPoint: "Cairo",
        way: Way.Round,
      ),
      state: TripState.Cancelled,
    ),
    History(
      trip: Trip(
        endPoint: "Alex",
        name: 'Alex',
        repeating: Repeating.Daily,
        startDate: DateTime.now(),
        startPoint: "Cairo",
        way: Way.Round,
      ),
      state: TripState.Cancelled,
    ),
  ];

  Future<void> fetchPastTrips() async {
    _pastTrips = await HistoryBox.pastTripsInTheBox;
  }

  List<History> get pastTrips {
    return [..._pastTrips];
  }

  void addPastTrip(History pastTrip) {
    try {
      HistoryBox.addPastTripToBox(pastTrip);
      _pastTrips.insert(0, pastTrip);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void deletePastTripe(History pastTrip) {
    if (!pastTrip.isInBox) {
      throw 'this element is not in the box';
    }
    try {
      HistoryBox.deletePastTripFromBox(pastTrip);
      final pastTripIndex =
          _pastTrips.indexWhere((trip) => trip.key == pastTrip.key);
      _pastTrips.removeAt(pastTripIndex);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
