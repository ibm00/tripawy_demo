import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants.dart';
import '../providers/upcoming_trips_provider.dart';

class NotesDialog extends ConsumerWidget {
  final int _key;
  NotesDialog(this._key);

  @override
  Widget build(BuildContext context, watch) {
    List<String?>? notes = watch(upcommingTripsProv).getTripNotes(_key);
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: notes!
              .map<Widget>(
                (note) => Material(
                  elevation: 60,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.deepOrange.withOpacity(.6),
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        child: Text(
                          note!,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: AppColors.darkPrimaryColor,
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
