import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/routing/app_routes.dart';
import '../../../../../../core/widgets/custom_material_button.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../filters/presentation/cubits/filter/filter_cubit.dart';
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
        var updateDateTime = DateTime.now().toIso8601String();
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
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await checkAndUpdateNote(updateDateTime, context);
                }
              },
              text: S.of(context).update_note,
            ),
          ],
        );
      },
    );
  }

  Future<void> checkAndUpdateNote(
    String updateDateTime,
    BuildContext context,
  ) async {
    final updatedTitle = _titleController.text;
    final updatedContent = _contentController.text;
    final updateFilterId = context.read<FilterCubit>().state.selectedFilterId;

    final bool isChanged = updatedTitle != widget.noteModel.title ||
        updatedContent != widget.noteModel.content ||
        updateFilterId != widget.noteModel.filterId;

    if (!isChanged) return;
    final updatedNote = widget.noteModel.copyWith(
      title: updatedTitle,
      content: updatedContent,
      lastUpdatedAt: updateDateTime,
      filterId: updateFilterId,
    );

    await context.read<UpdateNoteCubit>().updateNote(updatedNote);
  }
}
