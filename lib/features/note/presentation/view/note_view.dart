import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cubits/layout_cubit.dart';
import '../../../../core/cubits/selection/selection_cubit.dart';
import '../../../filters/data/repository/filter_repo.dart';
import '../../../filters/presentation/cubits/filter/filter_cubit.dart';
import '../../data/models/note_model.dart';
import '../cubits/get/notes_cubit.dart';
import 'widgets/note_body.dart';

class NoteView extends StatelessWidget {
  const NoteView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotesCubit(),
        ),
        BlocProvider(
          create: (context) => FilterCubit(FilterRepository())..loadFilters(),
        ),
        BlocProvider<SelectionCubit<NoteModel>>(
          create: (context) => SelectionCubit<NoteModel>(),
        ),
        BlocProvider(create: (context) => LayoutCubit()),
      ],
      child: const NoteBody(),
    );
  }
}
