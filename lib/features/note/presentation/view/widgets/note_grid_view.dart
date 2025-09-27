import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

import '../../../../home/data/models/note_model.dart';
import 'note_item.dart';

class NoteGridView extends StatelessWidget {
  const NoteGridView({super.key, required this.noteList});
  final List<NoteModel> noteList;
  @override
  Widget build(BuildContext context) {
    return DynamicHeightGridView(
      itemCount: noteList.length,
      crossAxisCount: (MediaQuery.of(context).size.width * 0.5) ~/ 200,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      builder: (context, index) => NoteItem(
        note: noteList[index],
        index: index,
      ),
    );
  }
}
