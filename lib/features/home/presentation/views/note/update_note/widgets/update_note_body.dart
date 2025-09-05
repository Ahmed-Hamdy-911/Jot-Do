import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../data/models/note_model.dart';
import '../../../../manager/cubits/notes/update/update_note_cubit.dart';
import '../../../../manager/cubits/notes/update/update_note_state.dart';
import '../../../../manager/cubits/pick_color/pick_color_cubit.dart';
import '../../../../manager/cubits/pick_color/pick_color_state.dart';
import 'update_note_form.dart';

class UpdateNoteBody extends StatelessWidget {
  const UpdateNoteBody({
    super.key,
    required this.noteModel,
  });
  final NoteModel noteModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PickColorCubit, PickColorState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).update_note),
              backgroundColor: state.selectedColor,
              leading: context.watch<UpdateNoteCubit>().state
                      is UpdateNoteLoadingState
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const BackButton(),
            ),
            body: AbsorbPointer(
              absorbing: false,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UpdateNoteForm(
                    noteModel: noteModel,
                  ),
                ),
              ),
            ));
      },
    );
  }
}
