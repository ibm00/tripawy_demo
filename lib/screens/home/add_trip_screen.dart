import 'package:flutter/material.dart';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripawy_demo/components/toast.dart';

import '../../constants.dart';
import '../../helpers/validator_helper.dart';
import '../../models/trip_models/repeat_enum.dart';
import '../../models/trip_models/trip_model.dart';
import '../../models/trip_models/way_enum.dart';
import '../../providers/upcoming_trips_provider.dart';

class AddTripScreen extends StatefulWidget {
  static const routName = 'add-trip';
  final Trip? _trip;
  AddTripScreen([this._trip]);

  @override
  _AddTripScreenState createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  @override
  void initState() {
    //  Hive.openBox<Trip>('upcomming_trips');
    if (widget._trip != null) {
      _name = widget._trip!.name;
      _startPoint = widget._trip!.startPoint;
      _endPoint = widget._trip!.endPoint;
      _dateTime = widget._trip!.startDate;
      _repeating = widget._trip!.repeating;
      _way = widget._trip!.way;
      _isEdit = true;
    }
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  bool _isEdit = false;

  String? _name = '';

  String? _startPoint = '';

  String? _endPoint = '';

  DateTime? _dateTime;

  Repeating? _repeating;

  Way? _way;

  // final _myFocusedBorder = OutlineInputBorder(
  //   borderSide: BorderSide(
  //     color: Colors.brown,
  //   ),
  //   borderRadius: BorderRadius.circular(20.0),
  // );

  @override
  Widget build(BuildContext context) {
    // final TextStyle _myHintSyle = TextStyle(
    //   fontStyle: FontStyle.italic,
    //   color: Colors.grey,
    //   fontSize: 17,
    // );
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text('Add New Trip',
              style: Theme.of(context).textTheme.headline1!),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trip name',
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: _name,
                    onSaved: (name) {
                      _name = name;
                    },
                    validator: (value) =>
                        ValidatorHelper.isEmptyValidator(value),
                    decoration: InputDecoration(
                      focusedBorder: AppStyles.myFocusedBorder,
                      hintText: 'Enter trip name...',
                      hintStyle: AppStyles.myHintSyle,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Start point',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    initialValue: _startPoint,
                    onSaved: (start) {
                      _startPoint = start;
                    },
                    validator: (value) =>
                        ValidatorHelper.isEmptyValidator(value),
                    decoration: InputDecoration(
                      focusedBorder: AppStyles.myFocusedBorder,
                      hintText: 'Enter start point...',
                      hintStyle: AppStyles.myHintSyle,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    'End point',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    initialValue: _endPoint,
                    onSaved: (endPoint) {
                      _endPoint = endPoint;
                    },
                    validator: (value) =>
                        ValidatorHelper.isEmptyValidator(value),
                    decoration: InputDecoration(
                      focusedBorder: AppStyles.myFocusedBorder,
                      focusColor: AppColors.darkPrimaryColor,
                      hintText: 'Enter end point...',
                      hintStyle: AppStyles.myHintSyle,
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Start Details',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    //dateMask: 'd MMM, yyyy',
                    initialValue: _dateTime.toString(),
                    initialTime: TimeOfDay(
                      hour: DateTime.now().hour,
                      minute: DateTime.now().minute + 1,
                    ),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    icon: Icon(
                      Icons.event,
                      color: Theme.of(context).accentColor,
                    ),
                    // use24HourFormat: false,
                    dateLabelText: 'Date',
                    timeLabelText: "Hour",
                    locale: Locale('en', 'US'),
                    validator: (date) =>
                        ValidatorHelper.dateTimeValidator(date),
                    onSaved: (date) {
                      String? tripDate =
                          date!.replaceAll('AM', "").replaceAll('PM', "");

                      // if (date!.length > 16) {
                      //   tripDate = date.substring(0, 17);
                      // }
                      print("daaaaaaaaaaate: $tripDate");
                      _dateTime = DateTime.parse(tripDate);
                    },
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 3,
                        child: DropdownButton<Repeating>(
                          dropdownColor: Colors.deepOrange[400],
                          hint: Text(
                            "Choose repeatation",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Theme.of(context).accentColor),
                          ),
                          isExpanded: true,
                          value: _repeating,
                          onChanged: (Repeating? result) {
                            setState(() {
                              _repeating = result;
                            });
                          },
                          items: [
                            const DropdownMenuItem<Repeating>(
                              value: Repeating.No,
                              child: Text('No Repeat'),
                            ),
                            const DropdownMenuItem<Repeating>(
                              value: Repeating.Daily,
                              child: Text('Repeat Daily'),
                            ),
                            const DropdownMenuItem<Repeating>(
                              value: Repeating.Weekly,
                              child: Text('Repeat Weekly'),
                            ),
                            const DropdownMenuItem<Repeating>(
                              value: Repeating.Monthly,
                              child: Text('Repeat Monthly'),
                            ),
                          ],
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        flex: 3,
                        child: DropdownButton<Way>(
                          dropdownColor: Colors.deepOrange[400],
                          hint: Text(
                            'Choose trip state',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Theme.of(context).accentColor),
                          ),
                          isExpanded: true,
                          value: _way,
                          onChanged: (Way? result) {
                            setState(() {
                              _way = result;
                            });
                            // if (_isEdit) widget._trip!.way = result;
                          },
                          items: [
                            const DropdownMenuItem<Way>(
                              value: Way.OneWay,
                              child: Text('One way trip'),
                            ),
                            const DropdownMenuItem<Way>(
                              value: Way.Round,
                              child: Text('Round trip'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Consumer(
                    builder: (context, watch, child) => Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;
                          if (_repeating == null) {
                            showCustomToast('Choose Reapeatatoin');
                            return;
                          }
                          if (_way == null) {
                            showCustomToast('Choose Trip State');
                            return;
                          }
                          _formKey.currentState!.save();
                          try {
                            if (_isEdit)
                              context.read(upcommingTripsProv).modifyTrip(
                                    Trip(
                                      endPoint: _endPoint,
                                      repeating: _repeating,
                                      startDate: _dateTime,
                                      startPoint: _startPoint,
                                      name: _name,
                                      way: _way,
                                    ),
                                    widget._trip!,
                                  );
                            else
                              context.read(upcommingTripsProv).addTrip(
                                    Trip(
                                      endPoint: _endPoint,
                                      repeating: _repeating,
                                      startDate: _dateTime,
                                      startPoint: _startPoint,
                                      name: _name,
                                      way: _way,
                                    ),
                                  );

                            print('saved');
                          } catch (e) {
                            showCustomToast('Some thing went wrong.');
                            print(e);
                          }
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).accentColor),
                        ),
                        child: Text(
                          'Save Trip',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
