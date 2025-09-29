import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/models/menu_item_model.dart';
import '../../../../../core/models/message_type.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/services/format_service.dart';
import '../../../../../core/widgets/components.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/note_model.dart';
import '../../cubits/get/notes_cubit.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.index,
    required this.note,
  });

  final int index;
  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    final colors = SmartAppColor(context);
    // final selectionCubit = context.watch<SelectionCubit<NoteModel>>();
    // final isSelectionMode = selectionCubit.state.isSelectionMode;
    // final isSelected = selectionCubit.state.selectedItems.contains(note);
    return InkWell(
      borderRadius: BorderRadius.circular(AppConstants.kRadius),
      onTap: () =>
          Navigator.pushNamed(context, AppRoutes.updateNote, arguments: note),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(AppConstants.kRadius),
        ),
        padding: const EdgeInsets.all(12),
        child: NoteBody(
          note: note,
          // isSelectionMode: isSelectionMode,
          // isSelected: isSelected,
        ),
      ),
    );
  }
}

class NoteBody extends StatelessWidget {
  const NoteBody({
    super.key,
    required this.note,
    this.isSelectionMode = false,
    this.isSelected = false,
  });

  final NoteModel note;

  final bool isSelectionMode;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colors = SmartAppColor(context);
    var createdAtDate = FormatService.formatDateTime(note.createdAt);
    var noteCubit = context.read<NotesCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                note.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppConstants.bodyLargeStyle(
                  colors.textPrimary,
                ),
              ),
            ),
            Row(
              children: [
                if (note.isFavorite)
                  InkWell(
                    onTap: () {
                      noteCubit.toggleFavoriteNote(note.id!, note);
                    },
                    child: Icon(
                      IconlyBold.star,
                      size: 20,
                      color: colors.amber,
                    ),
                  ),
                const SizedBox(
                  width: 8,
                ),
                if (note.isPinned)
                  InkWell(
                      onTap: () {
                        noteCubit.togglePinNote(note.id!, note);
                      },
                      child: const Icon(
                        Icons.push_pin,
                        size: 20,
                      )),
              ],
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              color: colors.backgroundScreen,
              splashRadius: 15,
              itemBuilder: (context) {
                return _noteMenuItems(context, note, noteCubit).map((item) {
                  return PopupMenuItem(
                    child: Row(
                      children: [
                        Text(item.title),
                      ],
                    ),
                    onTap: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        item.onTap?.call();
                      });
                    },
                  );
                }).toList();
              },
            )
          ],
        ),
        AppComponents.mediumVerticalSpace(),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: FormatService.getTruncatedText(text: note.content),
                style: AppConstants.bodySmallStyle(colors.textSecondary),
              ),
              if (note.content.length >
                  AppConstants.maxLengthOfContentNoteInHomeView)
                TextSpan(
                  text: "  ${S.of(context).more_details}",
                  style: TextStyle(
                    fontSize: 14,
                    color: colors.blue,
                  ),
                ),
            ],
          ),
        ),
        AppComponents.customDivider(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                createdAtDate,
                style: AppConstants.captionStyle(colors.textSecondary),
              ),
            ),
            if (note.isSynced != null)
              Icon(
                note.isSynced!
                    ? Icons.cloud_outlined
                    : Icons.cloud_off_outlined,
                size: 18,
                color: note.isSynced! ? colors.green : Colors.red,
              )
          ],
        ),
      ],
    );
  }
}

List<MenuItemModel> _noteMenuItems(
    BuildContext context, NoteModel note, NotesCubit notesCubit) {
  return [
    MenuItemModel(
      title: S.of(context).edit,
      onTap: () =>
          Navigator.pushNamed(context, AppRoutes.updateNote, arguments: note),
    ),
    MenuItemModel(
      title: note.isPinned ? S.of(context).un_pin : S.of(context).pin,
      onTap: () => notesCubit.togglePinNote(note.id!, note),
    ),
    MenuItemModel(
      title: note.isFavorite
          ? S.of(context).un_favorites
          : S.of(context).favorites,
      onTap: () => notesCubit.toggleFavoriteNote(note.id!, note),
    ),
    MenuItemModel(
      title: note.isArchived ? S.of(context).un_archive : S.of(context).archive,
      onTap: () => notesCubit.toggleArchiveNote(note.id!, note),
    ),
    MenuItemModel(
      title: S.of(context).delete,
      onTap: () {
        CustomSnackBar.showDialog(MessageType.warning, context,
            S.of(context).delete_note_confirmation, () {
          notesCubit.deleteNote(note.id!);
        });
      },
    ),
    MenuItemModel(
      title: S.of(context).select,
      // onTap: () => context.read<SelectionCubit>().toggleSelection(note),
    ),
  ];
}
