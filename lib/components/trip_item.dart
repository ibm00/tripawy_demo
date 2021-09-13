import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tripawy_demo/notifications/notifications.dart';
import 'notes_dialog.dart';
import 'toast.dart';
import '../constants.dart';
import '../models/trip_models/trip_model.dart';
import '../providers/upcoming_trips_provider.dart';
import '../screens/home/trip_notes_screen.dart';
import '../screens/home/add_trip_screen.dart';

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
                            onPressed: () {
                              AwesomeNotifications().cancelAllSchedules();
                              // Timer(
                              //   Duration(seconds: 10),
                              //   () => context
                              //       .read(upcommingTripsProv)
                              //       .deleteTrip(_trip),
                              // );
                            },
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
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) =>
                                        NotesDialog(_trip.key, false),
                                  );
                                },
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
        {
          // print('cancel keeeeeeeeey: ${_trip.key}');

          Navigator.of(ctx)
              .pushNamed(NotesScreen.routeName, arguments: _trip.key);
        }
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
        {
          Notifications.cancelSchedualedNotification(_trip.key);
          ctx.read(upcommingTripsProv).moveTheTripToHistory(_trip, false);
        }
        break;
      case PopUpOptions.delete:
        {
          try {
            Notifications.cancelSchedualedNotification(_trip.key);
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
