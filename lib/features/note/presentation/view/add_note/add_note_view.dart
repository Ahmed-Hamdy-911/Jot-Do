import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_loading.dart';
import '../../../../filters/data/repository/filter_repo.dart';
import '../../../../filters/presentation/cubits/filter/filter_cubit.dart';
import '../../cubits/add/add_note_cubit.dart';
import '../../cubits/add/add_note_state.dart';
import '../../../../../generated/l10n.dart';
import 'note_form.dart';

class AddNoteView extends StatelessWidget {
  const AddNoteView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddNoteCubit(),
        ),
        BlocProvider(
          create: (context) => FilterCubit(FilterRepository())..loadFilters(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).add_note),
        ),
        body: const AddNoteBody(),
      ),
    );
  }
}

class AddNoteBody extends StatelessWidget {
  const AddNoteBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomLoading(
      state: context.watch<AddNoteCubit>().state is AddNoteLoadingState,
      child: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: NoteForm(),
        ),
      ),
    );
  }
}
