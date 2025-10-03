import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/cubits/layout_cubit.dart';
import '../../../../../core/widgets/custom/custom_loading.dart';
import '../../../../../core/widgets/components/empty_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/note_model.dart';
import '../../cubits/get/notes_cubit.dart';
import '../../cubits/get/notes_state.dart';
import 'note_grid_view.dart';
import 'note_list_view.dart';

class NoteLayoutBuilder extends StatelessWidget {
  const NoteLayoutBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          final layoutType = context.watch<LayoutCubit>().state;
          return layoutType == LayoutType.grid
              ? NoteGridView(noteList: noteList)
              : NoteListView(noteList: noteList);
        },
      ),
    );
  }
}
