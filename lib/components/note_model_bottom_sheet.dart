import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'toast.dart';
import '../constants.dart';
import '../helpers/validator_helper.dart';
import '../models/exceptions_models/plus_ten_exception.dart';
import '../providers/upcoming_trips_provider.dart';

class NoteModelBottomSheet extends StatefulWidget {
  NoteModelBottomSheet(this._oldNote, this._key, this._index);
  final int _key;
  final int? _index;
  final String? _oldNote;
  @override
  _NoteModelBottomSheetState createState() => _NoteModelBottomSheetState();
}

class _NoteModelBottomSheetState extends State<NoteModelBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  bool _isEdit = false;
  String _note = "";

  // final _noteController = TextEditingController(text: "");

  @override
  void initState() {
    if (widget._index != null) {
      _isEdit = true;
      _note = widget._oldNote!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
          top: 20,
          bottom: 30 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                _isEdit ? "'Edit Your Note'" : '"Add A Note"',
                style: TextStyle(
                  color: Colors.brown[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: _note,
                // controller: _noteController,
                decoration: InputDecoration(
                  focusedBorder: AppStyles.myFocusedBorder,
                  hintText: 'Enter your note...',
                  hintStyle: AppStyles.myHintSyle,
                ),
                validator: (note) => ValidatorHelper.isEmptyValidator(note),
                onSaved: (note) {
                  _note = note!;
                  print("noooooooooote: $_note");
                },
              ),
              SizedBox(height: 60),
              Consumer(
                builder: (context, watch, child) => ElevatedButton(
                  onPressed: () => _saveData(context),
                  child: Text(
                    "Done",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: AppColors.darkPrimaryColor),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        AppColors.accentColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _saveData(BuildContext ctx) {
    if (!_formKey.currentState!.validate()) return null;
    _formKey.currentState!.save();
    try {
      final tripsProv = ctx.read(upcommingTripsProv);
      if (_isEdit) {
        tripsProv.modifyTripNote(_note, widget._key, widget._index!);
      } else {
        tripsProv.addTripNote(_note, widget._key);
      }
    } on PlusTenException catch (e) {
      showCustomToast(e.message);
    } catch (e) {
      print(e);
      showCustomToast('Some thing went wrong!');
    }
    Navigator.of(context).pop();
  }
}
