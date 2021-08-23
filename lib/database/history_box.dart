import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import '../models/history_models/history_model.dart';

class HistoryBox {
  static Future<List<History>> get pastTripsInTheBox async {
    final _historyBox = await Hive.openBox(
      'name',
      compactionStrategy: (entries, deletedEntries) => deletedEntries > 20,
    );
    return _historyBox.values.toList().reversed.toList().cast<History>();
  }

  static void addPastTripToBox(History pastTrip) {
    final Box<History> _pasrTripsBox = Hive.box('past_trips');
    _pasrTripsBox.add(pastTrip);
  }

  static void deletePastTripFromBox(History pastTrip) {
    pastTrip.delete();
  }
}
