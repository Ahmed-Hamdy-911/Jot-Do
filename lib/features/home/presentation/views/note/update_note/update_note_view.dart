import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/note_model.dart';
import '../../../manager/cubits/notes/update/update_note_cubit.dart';
import '../../../manager/cubits/pick_color/pick_color_cubit.dart';
import 'widgets/update_note_body.dart';

class UpdateNoteView extends StatelessWidget {
  const UpdateNoteView({super.key, required this.noteModel});
  final NoteModel noteModel;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PickColorCubit(),
        ),
        BlocProvider(
          create: (context) => UpdateNoteCubit(),
        ),
      ],
      child: UpdateNoteBody(
        noteModel: noteModel,
      ),
    );
  }
}


