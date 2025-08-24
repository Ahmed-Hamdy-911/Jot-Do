import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cubits/Selection/selection_state.dart';
import '../../../../../core/widgets/empty_widget.dart';
import '../../../../../core/widgets/filter_view_builder.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/cubits/Selection/selection_cubit.dart';
import '../../../data/models/note_model.dart';
import '../../manager/cubits/Note/NotesCubits/notes_cubit.dart';
import '../../manager/cubits/Note/NotesCubits/notes_state.dart';
import 'widgets/note_grid_view.dart';
import 'widgets/note_list_view.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotesCubit()..getNotes(),
        ),
        BlocProvider(
          create: (context) => SelectionCubit(),
        ),
      ],
      child: const NoteBody(),
    );
  }
}

class NoteBody extends StatelessWidget {
  const NoteBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> noteFilters = [
      S.of(context).filter_all,
      S.of(context).filter_new,
      S.of(context).filter_favorite,
      S.of(context).filter_archived,
      S.of(context).filter_pined,
    ];
    return MultiBlocListener(
      listeners: [
        BlocListener<NotesCubit, NotesStates>(
          listener: (context, state) {
            if (state is ToggleNoteActionsPinSuccessState ||
                state is ToggleNoteActionsArchiveSuccessState ||
                state is ToggleNoteFavoriteSuccessState ||
                state is NoteActionsDeleteSuccessState) {
              context.read<NotesCubit>().getNotes(
                    context.read<SelectionCubit>().state.selectedIndex,
                  );
            }
          },
        ),
        BlocListener<SelectionCubit, SelectionState>(
          listener: (context, state) {
            context.read<NotesCubit>().getNotes(state.selectedIndex);
          },
        ),
      ],
      child: Column(
        children: [
          FilterViewBuilder(filterList: noteFilters),
          const NoteLayoutBuilder()
        ],
      ),
    );
  }
}

class NoteLayoutBuilder extends StatelessWidget {
  const NoteLayoutBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    return BlocBuilder<NotesCubit, NotesStates>(
      builder: (context, state) {
        if (state is NotesLoadingState)
          return const Center(child: CircularProgressIndicator());
        List<NoteModel> noteList =
            BlocProvider.of<NotesCubit>(context).notesList ?? [];
        if (noteList.isEmpty)
          return EmptyWidget(
            text: S.of(context).no_notes_yet,
          );
        return Expanded(
          child: screenWidth >= 600
              ? NoteGridView(noteList: noteList)
              : NoteListView(
                  noteList: noteList,
                ),
        );
      },
    );
  }
}
