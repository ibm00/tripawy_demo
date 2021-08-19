import 'package:flutter/material.dart';
import 'package:tripawy_demo/constants.dart';
import 'package:tripawy_demo/models/trip_model.dart';

class NotesScreen extends StatefulWidget {
  NotesScreen([this._key]);
  final int? _key;

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Add Notes",
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
      ),
    );
  }
}
