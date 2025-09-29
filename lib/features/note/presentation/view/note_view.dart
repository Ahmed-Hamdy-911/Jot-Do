import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/components.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../../core/models/message_type.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../../core/widgets/empty_widget.dart';
import '../../../../core/widgets/filter_and_change_view.dart';
import '../../../../generated/l10n.dart';
import '../../../filters/data/repository/filter_repo.dart';
import '../../../filters/presentation/cubits/filter/filter_cubit.dart';
import '../../../filters/presentation/cubits/filter/filter_state.dart';
import '../../../home/presentation/cubits/top_body_navi/top_body_navi_cubit_.dart';
import '../../data/models/note_model.dart';
import '../cubits/get/notes_cubit.dart';
import '../cubits/get/notes_state.dart';
import 'widgets/note_grid_view.dart';
import 'widgets/note_list_view.dart';

class NoteView extends StatelessWidget {
  const NoteView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotesCubit()..getNotes("all"),
        ),
        BlocProvider(
          create: (context) => FilterCubit(FilterRepository()),
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

            if (state is ToggleNoteActionsArchiveSuccessState) {
              CustomSnackBar.showSnackBar(
                  state.isArchived == true
                      ? S.of(context).note_archived
                      : S.of(context).note_unarchived,
                  context,
                  MessageType.success);
            }
          },
        ),
        BlocListener<FilterCubit, FilterState>(
          listener: (context, state) {
            final selectedId = state.selectedFilterId;
            if (selectedId != null) {
              getNotesWithFilter(context, filterId: selectedId);
            } else {
              getNotesWithFilter(context);
            }
          },
        ),
      ],
      child: Column(
        children: [
          FilterAndChangeView(
            isInNotes: context.watch<TopBodyNaviCubit>().state == 0,
          ),
          AppComponents.customDivider(15),
          const NoteLayoutBuilder()
        ],
      ),
    );
  }

  void getNotesWithFilter(BuildContext context, {String? filterId}) {
    context.read<NotesCubit>().getNotes(filterId ?? "all");
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
