import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tripawy_demo/components/trip_item.dart';
import 'package:tripawy_demo/constants.dart';
import 'package:tripawy_demo/models/trip_model.dart';
import 'package:tripawy_demo/providers/upcomming_trips_provider.dart';
import 'package:tripawy_demo/screens/home/add_trip_screen.dart';

import '../splash-screen.dart';

class UpcommingTripsScreen extends StatefulWidget {
  @override
  _UpcommingTripsScreenState createState() => _UpcommingTripsScreenState();
}

class _UpcommingTripsScreenState extends State<UpcommingTripsScreen> {
  Future? futureBox;
  Future _futureBoxFun() async {
    await Hive.openBox<Trip>(
      'upcomming_trips',
      compactionStrategy: (entries, deletedEntries) => deletedEntries > 20,
    );
    context.read(upcommingTripsProv).fetchTrips();
  }

  @override
  void initState() {
    futureBox = _futureBoxFun();
    super.initState();
  }

  @override
  void dispose() {
    Hive.box('upcomming_trips').compact();
    Hive.box('upcomming_trips').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        title: Text(
          'Upcomming Trips',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: FutureBuilder(
        future: futureBox,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return SplashScreen();
          else if (snapshot.error != null)
            return Center(
              child: Text("error happend"),
            );
          else {
            return Consumer(
              builder: (context, watch, child) {
                final List<Trip> tripsList =
                    watch(upcommingTripsProv).upcommingTrips;
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
            );
          }
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
