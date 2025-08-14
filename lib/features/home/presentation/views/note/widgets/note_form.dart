import 'package:flutter/material.dart';
import 'package:jot_do/core/widgets/custom_material_button.dart';
import '../../../../../../core/constants/constant.dart';
import '../../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../../../core/widgets/custom_text_form.dart';
import '../../../../../../generated/l10n.dart';
import '../../../widgets/pick_color_grid_view.dart';

class NoteForm extends StatefulWidget {
  const NoteForm({super.key});

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  var _titleController = TextEditingController();
  var _contentController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  final InputBorder customBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppConstants.kRadius),
    borderSide: BorderSide.none,
  );
  final TextStyle customInputStyle = TextStyle(
    color: Colors.black,
    fontSize: 19,
  );
  final bool filled = true;
  final Color fillColor = Colors.grey.withOpacity(0.1);
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    final isWideScreen = screenWidth > 600;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hintText: S.of(context).note_title,
            controller: _titleController,
            customBorder: customBorder,
            maxLines: 2,
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
            controller: _contentController,
            customBorder: customBorder,
            maxLines: isWideScreen ? 7 : 16,
            filled: filled,
            fillColor: fillColor,
            customInputStyle: customInputStyle.copyWith(fontSize: 15),
          ),
          customDivider(),
          PickColorGridView(),
          customDivider(),
          const SmallSpace(),
          CustomMaterialButton(
            color: AppConstants.addNoteBGColor,
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
            text: S.of(context).save_note,
          ),
        ],
      ),
    );
  }

  Widget customDivider() => Divider(
        height: 15,
      );
}
