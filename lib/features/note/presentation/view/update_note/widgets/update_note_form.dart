import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/routing/app_routes.dart';
import '../../../../data/models/note_model.dart';
import '../../../cubits/update/update_note_cubit.dart';
import '../../../cubits/update/update_note_state.dart';
import 'update_note_form_body.dart';

class UpdateNoteForm extends StatefulWidget {
  const UpdateNoteForm({super.key, required this.noteModel});
  final NoteModel noteModel;

  @override
  State<UpdateNoteForm> createState() => UpdateNoteFormState();
}

class UpdateNoteFormState extends State<UpdateNoteForm> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get updateFormKey => _formKey;
  TextEditingController get titleController => _titleController;
  TextEditingController get contentController => _contentController;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.noteModel.title;
    _contentController.text = widget.noteModel.content;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
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
        return Form(
          key: _formKey,
          child: UpdateFormBody(
            noteModel: widget.noteModel,
            titleController: _titleController,
            contentController: _contentController,
          ),
        );
      },
    );
  }

}
