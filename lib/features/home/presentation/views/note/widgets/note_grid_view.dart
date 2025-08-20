import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants/constant.dart';
import 'note_item.dart';

class NoteGridView extends StatelessWidget {
  const NoteGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicHeightGridView(
      itemCount: 18,
      crossAxisCount: (MediaQuery.of(context).size.width * 0.5) ~/ 200,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      builder: (context, index) => NoteItem(
        index: index,
        color: AppConstants.noteColors[index],
      ),
    );
  }
}
