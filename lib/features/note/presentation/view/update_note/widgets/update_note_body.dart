import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/app_constants.dart';
import '../../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../../core/widgets/custom_loading.dart';
import '../../../../../../core/widgets/custom_material_button.dart';
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
    final formKey = GlobalKey<UpdateNoteFormState>();
    var screenWidth = MediaQuery.sizeOf(context).width;
    var isScreenWide = screenWidth > 600;
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
          actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
          actions: [
            CustomMaterialButton(
              minWidth: isScreenWide ? screenWidth * 0.1 : screenWidth * 0.2,
              height: isScreenWide ? 40.h : 30.h,
              color:
                  SmartAppColor(context).buttonPrimary.withValues(alpha: 0.8),
              radius: AppConstants.kRadius - 6,
              onPressed: () async {
                await _checkAndUpdateNote();
              },
              text: S.of(context).update_note,
            ),
          ],
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
        ));
  }
}
