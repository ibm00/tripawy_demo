import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripawy_demo/constants.dart';
import 'package:tripawy_demo/models/history_models/history_model.dart';

class HistoryItem extends StatelessWidget {
  final History _history;
  final TextStyle _historyTextStyle = TextStyle(fontSize: 17);

  HistoryItem(this._history);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColor.withOpacity(.8),
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
                  _history.state == TripState.Done ? 'Done' : 'Cancelled',
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
                onPressed: () {},
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
            onPressed: () {},
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
