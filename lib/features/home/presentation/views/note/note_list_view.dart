import 'package:flutter/material.dart';
import '../../../../../core/constants/constant.dart';
import '../../../../../core/widgets/constants_spaces_widgets.dart';
import 'note_item.dart';

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 17,
            itemBuilder: (context, index) => NoteItem(
              color: AppConstants.noteColors[index],
            ),
          ),
        ),
        const SmallSpace(),
      ],
    );
  }
}
