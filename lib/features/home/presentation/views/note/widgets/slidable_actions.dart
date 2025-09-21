import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toastification/toastification.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_constants.dart';
import '../../../../../../core/widgets/custom_snackbar.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../data/models/note_model.dart';
import '../../../cubits/notes/get/notes_cubit.dart';

ActionPane onDismissibleStartAction(BuildContext context,
    {required NoteModel note}) {
  final notesCubit = context.read<NotesCubit>();
  final s = S.of(context);

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
        onPressed: (_) {
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
                        notesCubit.deleteNote(note.id!);
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
        },
        backgroundColor: const Color(0xFFE53935),
        foregroundColor: Colors.white,
        icon: Icons.delete,
        label: s.delete,
        borderRadius: borderRadius,
      ),
    ],
  );
}

ActionPane onDismissibleEndAction(BuildContext context,
    {required NoteModel note}) {
  final notesCubit = context.read<NotesCubit>();
  final s = S.of(context);

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
        onPressed: (_) {
          notesCubit.togglePinNote(note.id!, note);
        },
        backgroundColor: const Color(0xFF26A69A),
        foregroundColor: Colors.white,
        icon: note.isPinned ? Icons.push_pin_outlined : Icons.push_pin,
        label: note.isPinned ? s.unpin : s.pin,
        borderRadius: borderRadius,
      ),
      SlidableAction(
        onPressed: (_) {
          notesCubit.toggleArchiveNote(note.id!, note);
        },
        backgroundColor: Colors.blueGrey.shade500,
        foregroundColor: Colors.white,
        icon: note.isArchived ? Icons.archive_outlined : Icons.archive,
        label: note.isArchived ? s.un_archive : s.archive,
        borderRadius: borderRadius,
      ),
    ],
  );
}
