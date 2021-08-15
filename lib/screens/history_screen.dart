import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'splash-screen.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future? futureBox;
  Future _futureBoxFun() async {
    return await Hive.openBox('past_trips');
  }

  @override
  void initState() {
    futureBox = _futureBoxFun();
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
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
            return Container();
          }
        },
      ),
    );
  }
}
