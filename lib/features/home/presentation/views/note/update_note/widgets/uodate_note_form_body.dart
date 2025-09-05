import 'package:flutter/material.dart';

import '../../../../../../../core/constants/app_constants.dart';
import '../../../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../../../../core/widgets/custom_text_form.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../../data/models/note_model.dart';
import 'update_note_pic_colors.dart';

class UpdateFormBody extends StatelessWidget {
  const UpdateFormBody(
      {super.key,
      required this.noteModel,
      required this.titleController,
      required this.contentController});
  final NoteModel noteModel;
  final TextEditingController titleController;
  final TextEditingController contentController;
  @override
  Widget build(BuildContext context) {
    final InputBorder customBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.kRadius),
      borderSide: BorderSide.none,
    );
    final TextStyle customInputStyle = const TextStyle(
      color: Colors.black,
      fontSize: 19,
    );
    final bool filled = true;
    final Color fillColor = Colors.grey.withValues(alpha: 0.1);
    var screenWidth = MediaQuery.sizeOf(context).width;
    final isWideScreen = screenWidth > 600;
    return Column(
      children: [
        CustomTextFormField(
          hintText: S.of(context).note_title,
          controller: titleController,
          customBorder: customBorder,
          maxLines: isWideScreen ? 3 : 2,
          customInputStyle: customInputStyle,
          filled: filled,
          fillColor: fillColor,
        ),
        customDivider(),
        CustomTextFormField(
          hintText: S.of(context).note_content,
          validator: (p0) {
            return null;
          },
          controller: contentController,
          customBorder: customBorder,
          maxLines: isWideScreen ? 12 : 16,
          filled: filled,
          fillColor: fillColor,
          customInputStyle: customInputStyle.copyWith(fontSize: 15),
        ),
        customDivider(),
        UpdateNotePicColors(
          note: noteModel,
        ),
        customDivider(),
        const SmallSpace(),
      ],
    );
  }

  Widget customDivider() => const Divider(
        height: 15,
      );
}
