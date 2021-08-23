import 'package:flutter/material.dart';
import 'package:tripawy_demo/constants.dart';
import 'package:tripawy_demo/screens/history_screen.dart';
import 'package:tripawy_demo/screens/home/upcoming_trips_screen.dart';

class AppDrawer extends StatelessWidget {
  final _drawerTextStryle = TextStyle(fontSize: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
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
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 60, left: 10, bottom: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor.withOpacity(.6),
                      AppColors.accentColor.withOpacity(1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 1],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.darkPrimaryColor,
                      child: Text(
                        "A",
                        style: _drawerTextStryle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      radius: 25,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Tripawy",
                      style: _drawerTextStryle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "eng.ibrahem@gmail.com",
                      style: _drawerTextStryle.copyWith(
                        color: AppColors.lightPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(UpcommingTripsScreen.routeName);
                },
                leading: Icon(Icons.drive_eta_rounded),
                title: Text(
                  "Upcoming",
                  style: _drawerTextStryle,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(HistoryScreen.routName);
                },
                leading: Icon(Icons.history),
                title: Text(
                  "History",
                  style: _drawerTextStryle,
                ),
              ),
              Divider(thickness: 1),
              Padding(
                padding: const EdgeInsets.only(left: 17),
                child: Text(
                  'Other',
                  style: TextStyle(fontSize: 20, color: AppColors.iconsColor),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.sync),
                title: Text(
                  "Sync",
                  style: _drawerTextStryle,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.logout),
                title: Text(
                  "Logout",
                  style: _drawerTextStryle,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
