import 'package:flutter/material.dart';
import '../../../../../../core/constants/constant.dart';
import 'note_item.dart';

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight + 5),
      itemCount: 17,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(top: 12),
        child: NoteItem(
          index: index,
          color: AppConstants.noteColors[index],
        ),
      ),
    ));
  }
}
