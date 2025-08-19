import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/filter_view_builder.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/cubits/selectionCubit/selection_cubit.dart';
import 'widgets/note_list_view.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return const NoteBody();
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
    return BlocProvider(
      create: (context) => SelectionCubit(),
      child: Column(
        children: [
          FilterViewBuilder(filterList: noteFilters),
          const ListViewBuilder(),
        ],
      ),
    );
  }
}
