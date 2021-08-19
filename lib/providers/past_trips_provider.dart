import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripawy_demo/database/past_trips_Boxes.dart';
import 'package:tripawy_demo/models/history_model.dart';

final historyProv = ChangeNotifierProvider((ref) => _HistoryProvider());

class _HistoryProvider extends ChangeNotifier {
  List<History> _pastTrips = [];
  List<History> get pastTrips {
    return [..._pastTrips];
  }

  void addPastTrip(History pastTrip) {
    try {
      PastTripsBox.addPastTripToBox(pastTrip);
      _pastTrips.insert(0, pastTrip);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void deletePastTripe(History pastTrip) {
    if (pastTrip.key == null) {
      print('this element is not in the box');
      return;
    }
    try {
      PastTripsBox.deletePastTripFromBox(pastTrip);
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
