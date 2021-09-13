import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripawy_demo/components/note_item.dart';
import 'package:tripawy_demo/components/note_model_bottom_sheet.dart';
import '../../constants.dart';
import '../../providers/upcoming_trips_provider.dart';

class NotesScreen extends ConsumerWidget {
  static const String routeName = 'note-screen';

  @override
  Widget build(BuildContext context, watch) {
    final mediaQuery = MediaQuery.of(context).size;
    final width = mediaQuery.width;
    final height = mediaQuery.height;
    final tripsProv = watch(upcommingTripsProv);
    final int? _key = ModalRoute.of(context)!.settings.arguments as int;
    final tripName = tripsProv.getTripName(_key!);
    final notesList = tripsProv.getTripNotes(_key);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "$tripName Trip Notes",
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showNoteModelBottomSheet(context, _key),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              '"You are allawed to enter only ten notes"',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 30,
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(8.0),
              separatorBuilder: (context, index) => Divider(thickness: 1),
              itemCount: notesList!.length,
              itemBuilder: (context, index) {
                final note = notesList[index];
                return NoteItem(
                  note,
                  index,
                  _key,
                  _showNoteModelBottomSheet,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNoteModelBottomSheet(context, _key),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  void _showNoteModelBottomSheet(
    BuildContext ctx,
    int tripKey, [
    int? index,
    String? oldNote,
  ]) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (context) => NoteModelBottomSheet(oldNote, tripKey, index),
    );
  }
}
