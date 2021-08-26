import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripawy_demo/constants.dart';
import 'package:tripawy_demo/models/history_models/history_model.dart';
import 'package:tripawy_demo/models/trip_models/trip_model.dart';
import 'package:tripawy_demo/providers/history_provider.dart';
import 'package:tripawy_demo/providers/upcoming_trips_provider.dart';

class NotificationServices {
  static void checkNotificationPermission(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then((isAllawed) {
      if (!isAllawed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Notification Permission'),
            content: Text('Our app would like to send notificaions'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Don\'t allow",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: () {
                  AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.of(context).pop());
                },
                child: Text(
                  "Allow",
                  style: TextStyle(fontSize: 18, color: Colors.teal),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  static void displayedStreem(BuildContext context) {
    AwesomeNotifications()
        .displayedStream
        .asBroadcastStream()
        .listen((notification) {
      print("Displayed Streeeeeeeeeem On Fire!!!!");
      context.read(upcommingTripsProv).fetchTrips();
    });
  }
}
