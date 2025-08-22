import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../../../core/constants/constant.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../data/models/note_model.dart';
import '../../../manager/cubits/Note/NotesCubits/notes_cubit.dart';

ActionPane onDismissibleStartAction(context, {required NoteModel note}) {
  var borderRadius = BorderRadius.only(
    topRight: AppConstants.isArabic()
        ? Radius.zero
        : Radius.circular(AppConstants.kRadius),
    bottomRight: AppConstants.isArabic()
        ? Radius.zero
        : Radius.circular(AppConstants.kRadius),
    topLeft: AppConstants.isArabic()
        ? Radius.circular(AppConstants.kRadius)
        : Radius.zero,
    bottomLeft: AppConstants.isArabic()
        ? Radius.circular(AppConstants.kRadius)
        : Radius.zero,
  );
  return ActionPane(
    motion: const DrawerMotion(),
    children: [
      SlidableAction(
        onPressed: (context) {
          context.read<NotesCubit>().deleteNote(note.id!, note);
        },
        backgroundColor: const Color(0xFFE53935),
        foregroundColor: Colors.white,
        icon: Icons.delete,
        label: S.of(context).delete,
        borderRadius: borderRadius,
      ),
    ],
  );
}

ActionPane onDismissibleEndAction(context, {required NoteModel note}) {
  var borderRadius = BorderRadius.only(
    topLeft: AppConstants.isArabic()
        ? Radius.zero
        : Radius.circular(AppConstants.kRadius),
    bottomLeft: AppConstants.isArabic()
        ? Radius.zero
        : Radius.circular(AppConstants.kRadius),
    topRight: AppConstants.isArabic()
        ? Radius.circular(AppConstants.kRadius)
        : Radius.zero,
    bottomRight: AppConstants.isArabic()
        ? Radius.circular(AppConstants.kRadius)
        : Radius.zero,
  );
  return ActionPane(
    motion: const DrawerMotion(),
    children: [
      SlidableAction(
        onPressed: (context) {
          context.read<NotesCubit>().togglePinNote(note.id!, note);
        },
        backgroundColor: const Color(0xFF26A69A),
        foregroundColor: Colors.white,
        icon: Icons.push_pin,
        label: S.of(context).pin,
        borderRadius: borderRadius,
      ),
      SlidableAction(
        onPressed: (context) {
          context.read<NotesCubit>().toggleArchiveNote(note.id!, note);
        },
        backgroundColor: Colors.blueGrey.shade500,
        foregroundColor: Colors.white,
        icon: Icons.archive,
        label: S.of(context).archive,
        borderRadius: borderRadius,
      ),
    ],
  );
}
