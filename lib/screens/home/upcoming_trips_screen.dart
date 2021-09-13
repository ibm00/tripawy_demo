import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripawy_demo/components/app_drawer.dart';
import 'package:tripawy_demo/components/trip_item.dart';
import 'package:tripawy_demo/notifications/notification_services.dart';
import '../../constants.dart';
import '../../models/trip_models/trip_model.dart';
import '../../providers/upcoming_trips_provider.dart';
import 'add_trip_screen.dart';

class UpcommingTripsScreen extends StatefulWidget {
  static const routeName = 'upcoming-trips-screen';

  @override
  _UpcommingTripsScreenState createState() => _UpcommingTripsScreenState();
}

class _UpcommingTripsScreenState extends State<UpcommingTripsScreen> {
  @override
  void initState() {
    NotificationServices.checkNotificationPermission(context);
    // NotificationServices.actionStreem(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        title: Text(
          'Upcomming Trips',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final List<Trip> tripsList = watch(upcommingTripsProv).upcommingTrips;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return TripItem(tripsList[index]);
              },
              separatorBuilder: (context, index) => Divider(
                endIndent: 50,
                indent: 50,
                color: AppColors.dividerColor,
              ),
              itemCount: tripsList.length,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddTripScreen.routName);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
