import 'package:flutter/material.dart';
import '../../../data/models/note_model.dart';
import 'note_item.dart';

class NoteListView extends StatelessWidget {
  const NoteListView({super.key, required this.noteList});
  final List<NoteModel> noteList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight + 5),
      itemCount: noteList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(top: 12),
        child: NoteItem(
          note: noteList[index],
          index: index,
        ),
      ),
    );
  }
}
