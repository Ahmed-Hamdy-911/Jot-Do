import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/cubits/selection/selection_cubit.dart';
import '../../../../../core/models/message_type.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../core/widgets/components/custom_snackbar.dart';
import '../../../../../core/widgets/filter/filter_and_change_view.dart';
import '../../../../../core/widgets/selection/selection_view.dart';
import '../../../../../generated/l10n.dart';
import '../../../../filters/presentation/cubits/filter/filter_cubit.dart';
import '../../../../filters/presentation/cubits/filter/filter_state.dart';
import '../../../../home/presentation/cubits/top_body_navi/top_body_navi_cubit_.dart';
import '../../../data/models/note_model.dart';
import '../../cubits/get/notes_cubit.dart';
import '../../cubits/get/notes_state.dart';
import 'note_layout_builder.dart';

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
  void initState() {
    getNotesWithFilter();
    super.initState();
  }

  Future<void> getNotesWithFilter({String? filterId}) async {
    await context.read<NotesCubit>().getNotes(filterId);
  }

  @override
  Widget build(BuildContext context) {
    final selectionCubit = context.watch<SelectionCubit<NoteModel>>();
    final isSelectionMode = selectionCubit.state.isSelectionMode;

    return MultiBlocListener(
      listeners: [
        BlocListener<FilterCubit, FilterState>(
          listener: (context, state) {
            final selectedId = state.selectedFilterId;
            if (selectedId != null) {
              getNotesWithFilter(filterId: selectedId);
            }
          },
        ),
        BlocListener<NotesCubit, NotesStates>(
          listener: (context, state) {
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
      ],
      child: RefreshIndicator(
        color: SmartAppColor(context).primary,
        backgroundColor: SmartAppColor(context).backgroundScreen,
        onRefresh: () async {
          await getNotesWithFilter(
              filterId: context.read<FilterCubit>().state.selectedFilterId);
        },
        child: Column(
          children: [
            if (isSelectionMode)
              SelectionView(
                selectionCubit: selectionCubit,
                notesCubit: context.read<NotesCubit>(),
              )
            else ...[
              FilterAndChangeView(
                isInNotes: context.watch<TopBodyNaviCubit>().state == 0,
              ),
            ],
            AppComponents.smallVerticalSpace(),
            AppComponents.customDivider(0),
            AppComponents.smallVerticalSpace(),
            const NoteLayoutBuilder()
          ],
        ),
      ),
    );
  }
}
