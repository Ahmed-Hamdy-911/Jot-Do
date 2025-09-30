import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_constants.dart';
import '../../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../../core/widgets/components.dart';
import '../../../../../../core/widgets/custom_filters_view.dart';
import '../../../../../../core/widgets/custom_show_time_to_page.dart';
import '../../../../../../core/widgets/custom_text_form.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../data/models/note_model.dart';

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
    var colors = SmartAppColor(context);
    final InputBorder customBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.kRadius),
      borderSide: BorderSide.none,
    );
    var textColor = colors.textSecondary;
    final bool filled = true;
    var screenWidth = MediaQuery.sizeOf(context).width;
    var screenHeight = MediaQuery.sizeOf(context).height;
    final isWideScreen = screenWidth > 600;
    final bool noContent = contentController.text.isEmpty;
    return Column(
      children: [
        CustomTextFormField(
          hintText: S.of(context).note_title,
          controller: titleController,
          customBorder: customBorder,
          maxLines: isWideScreen ? 3 : 2,
          customInputStyle: AppConstants.bodyLargeStyle(colors.textPrimary),
          filled: filled,
          fillColor: colors.fillColor,
        ),
        AppComponents.customDivider(15),
        CustomTextFormField(
          hintText: S.of(context).note_content,
          validator: (p0) {
            return null;
          },
          filled: filled,
          fillColor: colors.fillColor,
          controller: contentController,
          customBorder: customBorder,
          maxLines: noContent
              ? 5
              : isWideScreen
                  ? (screenHeight * 0.59 / 20).floor()
                  : (screenHeight * 0.6 / 24).floor(),
          customInputStyle: AppConstants.bodySmallStyle(textColor),
        ),
        AppComponents.customDivider(15),
        const CustomFiltersView(),
        AppComponents.customDivider(15),
        CustomShowTimeToPage(
          isUpdating: noteModel.lastUpdatedAt,
          createdAt: noteModel.createdAt,
          updatedAt: noteModel.lastUpdatedAt,
        ),
        AppComponents.smallVerticalSpace(),
      ],
    );
  }
}
