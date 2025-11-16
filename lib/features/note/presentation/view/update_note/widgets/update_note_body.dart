import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../../core/widgets/components/components.dart';
import '../../../../../../core/widgets/custom/custom_loading.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../filters/presentation/cubits/filter/filter_cubit.dart';
import '../../../../data/models/note_model.dart';
import '../../../cubits/update/update_note_cubit.dart';
import '../../../cubits/update/update_note_state.dart';
import 'update_note_form.dart';

class UpdateNoteBody extends StatelessWidget {
  const UpdateNoteBody({
    super.key,
    required this.noteModel,
  });
  final NoteModel noteModel;
  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    final formKey = GlobalKey<UpdateNoteFormState>();
    final updateDateTime = DateTime.now().toIso8601String();
    Future<void> _checkAndUpdateNote() async {
      final formState = formKey.currentState;
      if (formState == null) return;
      if (formState.updateFormKey.currentState!.validate()) {
        final updatedTitle = formState.titleController.text;
        final updatedContent = formState.contentController.text;
        final updateFilterId =
            context.read<FilterCubit>().state.selectedFilterId;

        final bool isChanged = updatedTitle != noteModel.title ||
            updatedContent != noteModel.content ||
            updateFilterId != noteModel.filterId;

        if (!isChanged) return;

        final updatedNote = noteModel.copyWith(
          title: updatedTitle,
          content: updatedContent,
          lastUpdatedAt: updateDateTime,
          filterId: updateFilterId,
        );

        await context.read<UpdateNoteCubit>().updateNote(updatedNote);
      }
    }

    bool isLoading =
        context.watch<UpdateNoteCubit>().state is UpdateNoteLoadingState;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).edit),
      ),
      body: CustomLoading(
        state: isLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: UpdateNoteForm(
              key: formKey,
              noteModel: noteModel,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: colors.reverseBackgroundColor.withValues(alpha: 0.6),
          foregroundColor: colors.textInverse,
          elevation: 0,
          shape: const CircleBorder(),
          tooltip: S.of(context).update_note,
          onPressed: () async {
            await _checkAndUpdateNote();
          },
          child: isLoading
              ? AppComponents.customCircleLoading(context,
                  color: colors.textInverse)
              : const Icon(
                  Icons.done,
                )),
    );
  }
}
