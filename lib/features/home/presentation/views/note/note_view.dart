import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/empty_widget.dart';
import '../../../../../core/widgets/filter_view_builder.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/cubits/selectionCubit/selection_cubit.dart';
import '../../../data/models/note_model.dart';
import '../../manager/cubits/NoteCubits/cubit/notes_cubit.dart';
import '../../manager/cubits/NoteCubits/cubit/notes_state.dart';
import 'widgets/note_grid_view.dart';
import 'widgets/note_list_view.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit()..getNotes(),
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
    return BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {
        if (state is GetAllNotesSuccessState) {
          print("Success");
        }
      },
      builder: (context, state) {
        if (state is NotesLoadingState)
          return const Center(child: CircularProgressIndicator());
        List<NoteModel> noteList =
            BlocProvider.of<NotesCubit>(context).notesList ?? [];
        if (noteList.isEmpty)
          return EmptyWidget(
            text: S.of(context).no_notes_yet,
          );
        return BodyBuilder(
          noteList: noteList,
        );
      },
    );
  }
}

class BodyBuilder extends StatelessWidget {
  const BodyBuilder({super.key, required this.noteList});
  final List<NoteModel> noteList;
  @override
  Widget build(BuildContext context) {
    final List<String> noteFilters = [
      S.of(context).filter_all,
      S.of(context).filter_new,
      S.of(context).filter_favorite,
      S.of(context).filter_archived,
      S.of(context).filter_pined,
    ];
    var screenWidth = MediaQuery.sizeOf(context).width;
    return BlocProvider(
      create: (context) => SelectionCubit(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FilterViewBuilder(filterList: noteFilters),
          Expanded(
              child: screenWidth >= 600
                  ? NoteGridView(noteList: noteList)
                  : NoteListView(
                      noteList: noteList,
                    )),
        ],
      ),
    );
  }
}
