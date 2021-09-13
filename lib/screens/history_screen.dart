import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tripawy_demo/components/app_drawer.dart';
import 'package:tripawy_demo/components/history_item.dart';
import 'package:tripawy_demo/constants.dart';
import 'package:tripawy_demo/models/history_models/history_model.dart';
import 'package:tripawy_demo/providers/history_provider.dart';

import 'splash-screen.dart';

class HistoryScreen extends StatefulWidget {
  static const routName = 'histoty-screen';
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future? futureBox;
  Future _futureBoxFun() async {
    return;
    // return await Hive.openBox(
    //   'past_trips',
    //   compactionStrategy: (entries, deletedEntries) => deletedEntries > 20,
    // );
  }

  @override
  void initState() {
    futureBox = _futureBoxFun();
    super.initState();
  }

  // @override
  // void dispose() {
  //   Hive.box('past_trips').compact();
  //   Hive.box('past_trips').close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      // backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "History",
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
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
                final List<History> pastTrips = watch(historyProv).pastTrips;
                return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return HistoryItem(pastTrips[index]);
                  },
                  itemCount: pastTrips.length,
                );
              },
            );
          }
        },
      ),
    );
  }
}
