import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tripawy_demo/providers/upcoming_trips_provider.dart';
import 'package:tripawy_demo/screens/history_screen.dart';
import 'package:tripawy_demo/screens/splash-screen.dart';
import 'constants.dart';
import 'models/history_models/trip_state_enum.dart';
import 'models/trip_models/repeat_enum.dart';
import 'models/trip_models/way_enum.dart';
import 'screens/home/add_trip_screen.dart';

import 'models/history_models/history_model.dart';
import 'models/trip_models/trip_model.dart';

import 'screens/home/trip_notes_screen.dart';
import 'screens/home/upcoming_trips_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TripAdapter());
  Hive.registerAdapter(HistoryAdapter());
  Hive.registerAdapter(RepeatingAdapter());
  Hive.registerAdapter(WayAdapter());
  Hive.registerAdapter(TripStateAdapter());
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => ProviderScope(child: MyApp()), // Wrap your app
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future? _openTheBoxAndFetchData;
  Future _futureBoxFun() async {
    return await context.read(upcommingTripsProv).fetchTrips();
  }

  @override
  void initState() {
    _openTheBoxAndFetchData = _futureBoxFun();
    print('opend');
    super.initState();
  }

  @override
  void dispose() {
    Hive.box<Trip>('upcomming_trips').compact();
    Hive.box<Trip>('upcomming_trips').close();
    print('closed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tripawy',
      theme: ThemeData(
        fontFamily: 'PatrickHand',
        primaryColor: AppColors.darkPrimaryColor,
        accentColor: AppColors.accentColor,
        textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
            subtitle1: TextStyle(fontSize: 20)),
      ),
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en', 'US')],
      home: FutureBuilder(
        future: _openTheBoxAndFetchData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return SplashScreen();
          else if (snapshot.error != null)
            return Center(
              child: Text("error happend"),
            );
          else {
            return UpcommingTripsScreen();
          }
        },
      ),
      routes: {
        AddTripScreen.routName: (_) => AddTripScreen(),
        NotesScreen.routeName: (_) => NotesScreen(),
        HistoryScreen.routName: (_) => HistoryScreen(),
        UpcommingTripsScreen.routeName: (_) => UpcommingTripsScreen(),
      },
    );
  }
}
