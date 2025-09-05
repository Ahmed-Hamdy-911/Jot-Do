import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../manager/cubits/notes/add/add_note_cubit.dart';
import '../../../manager/cubits/notes/add/add_note_state.dart';
import '../../../manager/cubits/pick_color/pick_color_cubit.dart';
import '../../../manager/cubits/pick_color/pick_color_state.dart';
import '../../../../../../generated/l10n.dart';
import 'note_form.dart';

class AddNoteView extends StatelessWidget {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PickColorCubit(),
        ),
        BlocProvider(
          create: (context) => AddNoteCubit(),
        ),
      ],
      child: const AddNoteScaffold(),
    );
  }
}

class AddNoteScaffold extends StatelessWidget {
  const AddNoteScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PickColorCubit, PickColorState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).add_note),
              backgroundColor: state.selectedColor,
              leading:
                  context.watch<AddNoteCubit>().state is AddNoteLoadingState
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const BackButton(),
            ),
            body: AbsorbPointer(
              absorbing:
                  context.watch<AddNoteCubit>().state is AddNoteLoadingState,
              child: const SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: NoteForm(),
                ),
              ),
            ));
      },
    );
  }
}
