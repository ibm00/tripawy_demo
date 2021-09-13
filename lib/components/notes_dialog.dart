import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripawy_demo/providers/history_provider.dart';
import '../constants.dart';
import '../providers/upcoming_trips_provider.dart';

class NotesDialog extends ConsumerWidget {
  final int _key;
  final bool _isPast;
  NotesDialog(this._key, this._isPast);

  @override
  Widget build(BuildContext context, watch) {
    final notes = _isPast
        ? watch(historyProv).getPastTripNotes(_key) as List<String?>?
        : watch(upcommingTripsProv).getTripNotes(_key) as List<String?>?;
    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      child: notes!.isEmpty
          ? Center(
              child: Text(
                '"There is no notes for this trip"',
                style: TextStyle(fontSize: 20),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: notes
                    .map<Widget>(
                      (note) => Material(
                        color: AppColors.backgroundColor,
                        elevation: 60,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          color: Colors.deepOrange.withOpacity(.6),
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            note!,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
