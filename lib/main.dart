import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'models/trip_model.dart';
import 'screens/home/upcomming_trips_screen.dart';

void main() {
  Hive.initFlutter();
  Hive.registerAdapter(TripAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tripawy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UpcommingTripsScreen(),
    );
  }
}
