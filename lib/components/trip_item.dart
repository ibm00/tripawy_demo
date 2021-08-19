import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tripawy_demo/components/toast.dart';
import 'package:tripawy_demo/constants.dart';
import 'package:tripawy_demo/models/trip_model.dart';
import 'package:tripawy_demo/providers/upcomming_trips_provider.dart';
import 'package:tripawy_demo/screens/home/add_trip_screen.dart';

enum PopUpOptions { notes, edit, delete, cancel }

class TripItem extends StatelessWidget {
  TripItem(this._trip);

  final Trip _trip;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = constraints.maxWidth;
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepOrange.withOpacity(.7),
                      AppColors.backgroundColor!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 1],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            DateFormat.yMMMd().format(_trip.startDate!),
                            style: _calculateCardTextStyle(cardWidth),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            DateFormat.jm().format(_trip.startDate!),
                            style: _calculateCardTextStyle(cardWidth),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Consumer(
                              builder: (context, watch, child) =>
                                  PopupMenuButton(
                                onSelected: (PopUpOptions selectedOption) =>
                                    _doThisInstruction(selectedOption, context),
                                child: Icon(
                                  Icons.menu,
                                  size: cardWidth * .1,
                                  color: AppColors.primaryColor,
                                ),
                                itemBuilder: (context) =>
                                    <PopupMenuItem<PopUpOptions>>[
                                  PopupMenuItem(
                                    child: Text('Add Note'),
                                    value: PopUpOptions.notes,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Edit'),
                                    value: PopUpOptions.edit,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Cancel'),
                                    value: PopUpOptions.cancel,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Delete'),
                                    value: PopUpOptions.delete,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: .025 * cardWidth),
                    Row(
                      children: [
                        Expanded(
                            child: Text(_trip.name!,
                                style: _calculateCardTextStyle(cardWidth))),
                        Expanded(
                            child: Text('Upcoming',
                                style: _calculateCardTextStyle(cardWidth))),
                      ],
                    ),
                    Divider(endIndent: 100, thickness: 2),
                    Row(
                      children: [
                        Icon(Icons.arrow_downward),
                        Column(
                          children: [
                            Text(
                              _trip.startPoint!,
                              style: _calculateCardTextStyle(cardWidth),
                            ),
                            Text(
                              _trip.endPoint!,
                              style: _calculateCardTextStyle(cardWidth),
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(endIndent: 40, thickness: 2),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color?>(
                                AppColors.accentColor,
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Start",
                              style: _calculateCardTextStyle(cardWidth),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: cardWidth > 510 ? cardWidth * 0.035 : 0,
                                bottom: cardWidth > 510 ? cardWidth * .04 : 0,
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.note,
                                  size: cardWidth * .1,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  TextStyle _calculateCardTextStyle(double w) {
    return TextStyle(
      fontSize: w * .06,
    );
  }

  _doThisInstruction(PopUpOptions selectedOption, BuildContext ctx) {
    switch (selectedOption) {
      case PopUpOptions.notes:
        {}
        break;
      case PopUpOptions.edit:
        {
          Navigator.of(ctx).push(
            MaterialPageRoute(
              builder: (context) => AddTripScreen(_trip),
            ),
          );
        }
        break;
      case PopUpOptions.cancel:
        {}
        break;
      case PopUpOptions.delete:
        {
          try {
            ctx.read(upcommingTripsProv).deleteTrip(_trip);
          } catch (e) {
            print(e);
            showCustomToast('Some thing went wrong!');
          }
        }
        break;
    }
  }
}
