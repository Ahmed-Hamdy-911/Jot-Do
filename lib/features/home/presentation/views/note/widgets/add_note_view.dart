import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jot_do/features/home/presentation/manager/cubits/PickColor/pick_color_cubit.dart';
import 'package:jot_do/features/home/presentation/manager/cubits/PickColor/pick_color_state.dart';
import 'package:jot_do/generated/l10n.dart';
import 'note_form.dart';

class AddNoteView extends StatelessWidget {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PickColorCubit(),
      child: AddNoteScaffold(),
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
              surfaceTintColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: NoteForm(),
              ),
            ));
      },
    );
  }
}
