import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripawy_demo/components/notes_dialog.dart';
import 'package:tripawy_demo/constants.dart';
import 'package:tripawy_demo/models/history_models/history_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripawy_demo/providers/history_provider.dart';

class HistoryItem extends StatelessWidget {
  final History _history;
  final TextStyle _historyTextStyle = TextStyle(fontSize: 17);

  HistoryItem(this._history);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.primaryColor,
      child: Column(
        children: [
          ExpansionTileCard(
            baseColor: AppColors.backgroundColor!.withOpacity(.8),
            expandedColor: AppColors.backgroundColor!.withOpacity(.9),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _history.trip!.name!,
                  style: TextStyle(fontSize: 22),
                ),
                Text(
                  _history.isTripDone! ? 'Done' : 'Cancelled',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateFormat.yMMMMd().format(_history.trip!.startDate!),
                        style: _historyTextStyle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        DateFormat.jm().format(_history.trip!.startDate!),
                        style: _historyTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                children: [
                  Icon(Icons.arrow_downward),
                  Column(
                    children: [
                      Text(
                        _history.trip!.startPoint!,
                        style: _historyTextStyle,
                      ),
                      Text(
                        _history.trip!.endPoint!,
                        style: _historyTextStyle,
                      ),
                    ],
                  )
                ],
              ),
              Divider(),
              ElevatedButton(
                onPressed: () {
                  print('keyyyy: ${_history.trip!.key}');
                  showDialog(
                    context: context,
                    builder: (context) => NotesDialog(_history.key, true),
                  );
                },
                child: Text(
                  "Show Notes",
                  style: _historyTextStyle,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.primaryColor.withOpacity(.6),
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              context.read(historyProv).deletePastTripe(_history);
            },
            child: Text(
              "Delete",
              style: _historyTextStyle.copyWith(color: Colors.black),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                AppColors.backgroundColor!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
