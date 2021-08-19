import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tripawy_demo/constants.dart';
import 'package:tripawy_demo/models/repeat_enum.dart';
import 'package:tripawy_demo/models/way_enum.dart';
import 'package:tripawy_demo/screens/home/add_trip_screen.dart';

import 'models/history_model.dart';
import 'models/trip_model.dart';

import 'screens/home/add_note_screen.dart';
import 'screens/home/upcomming_trips_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TripAdapter());
  Hive.registerAdapter(HistoryAdapter());
  Hive.registerAdapter(RepeatingAdapter());
  Hive.registerAdapter(WayAdapter());
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => ProviderScope(child: MyApp()), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
      routes: {
        '/': (_) => UpcommingTripsScreen(),
        AddTripScreen.routName: (_) => AddTripScreen(),
      },
    );
  }
}
