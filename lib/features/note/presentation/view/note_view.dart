import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../../core/models/message_type.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../../core/widgets/empty_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../home/data/models/note_model.dart';
import '../cubits/get/notes_cubit.dart';
import '../cubits/get/notes_state.dart';
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
      ],
      child: const NoteBody(),
    );
  }
}

class NoteBody extends StatefulWidget {
  const NoteBody({
    super.key,
  });

  @override
  State<NoteBody> createState() => _NoteBodyState();
}

class _NoteBodyState extends State<NoteBody> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NotesCubit, NotesStates>(
          listener: (context, state) {
            if (state is ToggleNoteActionsPinSuccessState ||
                state is ToggleNoteActionsArchiveSuccessState ||
                state is ToggleNoteFavoriteSuccessState ||
                state is NoteActionsDeleteSuccessState) {
              getNotesWithFilter(context);
            }

            if (state is ToggleNoteActionsPinSuccessState) {
              CustomSnackBar.showSnackBar(
                  state.isPinned == true
                      ? S.of(context).note_pined
                      : S.of(context).note_unpined,
                  context,
                  MessageType.success);
            }

            if (state is ToggleNoteFavoriteSuccessState) {
              CustomSnackBar.showSnackBar(
                  state.isFavorite == true
                      ? S.of(context).favorited
                      : S.of(context).unfavorited,
                  context,
                  MessageType.success);
            }
          },
        ),
      ],
      child: const Column(
        children: [NoteLayoutBuilder()],
      ),
    );
  }

  void getNotesWithFilter(BuildContext context) {
    context.read<NotesCubit>().getNotes();
  }
}

class NoteLayoutBuilder extends StatelessWidget {
  const NoteLayoutBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    return Expanded(
      child: BlocBuilder<NotesCubit, NotesStates>(
        builder: (context, state) {
          if (state is NotesLoadingState)
            return const CustomLoading(
              state: true,
              child: SizedBox(),
            );
          List<NoteModel> noteList =
              BlocProvider.of<NotesCubit>(context).notesList;
          if (noteList.isEmpty)
            return EmptyWidget(
              text: S.of(context).no_notes_yet,
            );
          return screenWidth >= 600
              ? NoteGridView(noteList: noteList)
              : NoteListView(
                  noteList: noteList,
                );
        },
      ),
    );
  }
}
