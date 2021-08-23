import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/upcoming_trips_provider.dart';

class NoteItem extends StatelessWidget {
  final int? _index;
  final int? _key;
  final String? _note;
  final Function _shwoModalFun;
  NoteItem(this._note, this._index, this._key, this._shwoModalFun);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.brown.withOpacity(.5),
      title: Text(_note!),
      trailing: Consumer(
        builder: (context, watch, child) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                _shwoModalFun(context, _key, _index, _note);
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read(upcommingTripsProv).deleteTripNote(_key!, _index!);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
