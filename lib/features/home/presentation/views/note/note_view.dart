import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/cubits/filter/filter_state.dart';
import '../../../../../core/cubits/selection/selection_cubit.dart';
import '../../../../../core/cubits/settings/setting_cubit.dart';
import '../../../../../core/models/message_type.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../../../core/widgets/empty_widget.dart';
import '../../../../../core/widgets/filter_view_builder.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/cubits/filter/filter_cubit.dart';
import '../../../data/models/note_model.dart';
import '../../cubits/notes/get/notes_cubit.dart';
import '../../cubits/notes/get/notes_state.dart';
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
          create: (context) => FilterCubit(),
        ),
        BlocProvider(
          create: (context) => SelectionCubit<NoteModel>(),
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
            if (context
                .read<SelectionCubit<NoteModel>>()
                .state
                .selectedItems
                .isNotEmpty) {
              if (state is ToggleNoteActionsArchiveSuccessState) {
                CustomSnackBar.showSnackBar(
                    state.isArchived == true
                        ? S.of(context).note_archived
                        : S.of(context).note_unarchived,
                    context,
                    MessageType.success);
              }

              if (state is NoteActionsDeleteSuccessState) {
                CustomSnackBar.showSnackBar(
                  S.of(context).note_deleted,
                  context,
                  MessageType.success,
                );
              }
            }
          },
        ),
        BlocListener<FilterCubit, FilterState>(
          listener: (context, state) {
            context.read<NotesCubit>().getNotes(state.selectedIndex);
          },
        ),
      ],
      child: Column(
        children: [
          Stack(
            children: [
              FilterViewBuilder(filterList: noteFilters),
              if (context
                  .watch<SelectionCubit<NoteModel>>()
                  .state
                  .isSelectionMode)
                Container(
                  height: MediaQuery.of(context).size.width > 600 ? 40 : 40,
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.mainLightColor.withAlpha(250),
                  child: Row(
                    children: [
                      BackButton(
                        color: context.watch<SettingCubit>().state.themeMode ==
                                ThemeMode.dark
                            ? AppColor.white70
                            : AppColor.whiteColor,
                        onPressed: () {
                          context
                              .read<SelectionCubit<NoteModel>>()
                              .clearSelection();
                        },
                      ),
                      const SizedBox(width: 10),
                      const NoteSelectionDropdown(),
                    ],
                  ),
                ),
            ],
          ),
          const NoteLayoutBuilder()
        ],
      ),
    );
  }

  void getNotesWithFilter(BuildContext context) {
    context.read<NotesCubit>().getNotes(
          context.read<FilterCubit>().state.selectedIndex,
        );
  }
}

class NoteSelectionDropdown extends StatelessWidget {
  const NoteSelectionDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
    final notesCubit = context.read<NotesCubit>();
    final s = S.of(context);
    return Expanded(
      child: DropdownButton<int>(
        value: 0,
        alignment: AlignmentDirectional.center,
        isExpanded: true,
        iconEnabledColor: AppColor.white70,
        dropdownColor: isDark ? AppColor.grey600 : AppColor.whiteColor,
        style: TextStyle(
          fontSize: 15,
          color: isDark ? AppColor.white70 : AppColor.whiteColor,
        ),
        items: [
          DropdownMenuItem(
            value: 0,
            child: Text(
              S.of(context).delete,
              style: TextStyle(
                color: isDark ? AppColor.white70 : AppColor.blackColor,
              ),
            ),
          ),
          DropdownMenuItem(
            value: 1,
            child: Text(
              S.of(context).archive,
              style: TextStyle(
                color: isDark ? AppColor.white70 : AppColor.blackColor,
              ),
            ),
          ),
        ],
        onChanged: (_) {
          final selectionCubit = context.read<SelectionCubit<NoteModel>>();
          final selectedItems = selectionCubit.state.selectedItems;

          if (_ == 0) {
            final selectedIds = selectedItems.map((e) => e.id!).toList();
            for (var id in selectedIds) {
              CustomSnackBar.showToastification(
                context,
                message: s.delete_note_confirmation,
                children: [
                  WidgetSpan(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            toastification.dismissAll();
                            notesCubit.deleteNote(id);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                AppColor.redColor.withValues(alpha: 0.2),
                          ),
                          child: Text(
                            s.yes,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.redDarkColor,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => toastification.dismissAll(),
                          style: TextButton.styleFrom(
                            backgroundColor:
                                AppColor.blueColor.withValues(alpha: 0.2),
                          ),
                          child: Text(
                            s.no,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.blueColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                type: ToastificationType.warning,
              );
            }
            selectionCubit.clearSelection();
          } else if (_ == 1) {
            for (var note in selectedItems) {
              context.read<NotesCubit>().toggleArchiveNote(note.id!, note);
            }
            selectionCubit.clearSelection();
          }
        },
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
        if (state is NotesLoadingState) return const LinearProgressIndicator();
        List<NoteModel> noteList =
            BlocProvider.of<NotesCubit>(context).notesList;
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
