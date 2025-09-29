import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/routing/app_routes.dart';
import '../../../../../../core/widgets/custom_material_button.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../data/models/note_model.dart';
import '../../../cubits/update/update_note_cubit.dart';
import '../../../cubits/update/update_note_state.dart';
import 'update_note_form_body.dart';

class UpdateNoteForm extends StatefulWidget {
  const UpdateNoteForm({super.key, required this.noteModel});
  final NoteModel noteModel;
  @override
  State<UpdateNoteForm> createState() => _UpdateNoteFormState();
}

class _UpdateNoteFormState extends State<UpdateNoteForm> {
  var _titleController = TextEditingController();
  var _contentController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.noteModel.title;
    _contentController.text = widget.noteModel.content;
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateNoteCubit, UpdateNoteStates>(
      listener: (context, state) {
        if (state is UpdateNoteSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        var dateTime = DateTime.now().toIso8601String();
        return Column(
          children: [
            Form(
                key: _formKey,
                child: UpdateFormBody(
                  noteModel: widget.noteModel,
                  titleController: _titleController,
                  contentController: _contentController,
                )),
            CustomMaterialButton(
              isLoading: state is UpdateNoteLoadingState,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  checkAndUpdateNote(dateTime, context);
                }
              },
              text: S.of(context).update_note,
            ),
          ],
        );
      },
    );
  }

  void checkAndUpdateNote(
    String dateTime,
    BuildContext context,
  ) {
    final updatedTitle = _titleController.text;
    final updatedContent = _contentController.text;
    // ignore: deprecated_member_use
    final updatedColor = null;

    final bool isChanged = updatedTitle != widget.noteModel.title ||
        updatedContent != widget.noteModel.content ||
        updatedColor != widget.noteModel.color;

    if (isChanged) {
      widget.noteModel.title = updatedTitle;
      widget.noteModel.content = updatedContent;
      widget.noteModel.color = updatedColor;
      widget.noteModel.lastUpdatedAt = dateTime;

      context.read<UpdateNoteCubit>().updateNote(widget.noteModel);
    } else {}
  }
}
