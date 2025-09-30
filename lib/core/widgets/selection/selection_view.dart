import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../features/note/data/models/note_model.dart';
import '../../../features/note/presentation/cubits/get/notes_cubit.dart';
import '../../../generated/l10n.dart';
import '../../constants/app_constants.dart';
import '../../constants/colors/smart_app_color.dart';
import '../../cubits/selection/selection_cubit.dart';
import '../../models/menu_item_model.dart';

class SelectionView extends StatelessWidget {
  const SelectionView({
    super.key,
    required this.selectionCubit,
    required this.notesCubit,
  });

  final SelectionCubit<NoteModel> selectionCubit;
  final NotesCubit notesCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: SmartAppColor(context).backgroundMuted,
        borderRadius: BorderRadius.circular(500),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: getSelectionMenuNotesItems(
                context,
                selectionCubit: selectionCubit,
                notesCubit: notesCubit,
                notes: notesCubit.notesList,
              ).map((item) {
                if (item.widget != null) return item.widget!;
                return IconButton(
                  icon: Icon(item.icon),
                  tooltip: item.title,
                  color: item.color ?? SmartAppColor(context).primary,
                  onPressed: item.onTap ?? null,
                );
              }).toList(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: SmartAppColor(context).red,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.zero,
            child: IconButton(
              icon: const Icon(Icons.close),
              color: SmartAppColor(context).primary,
              onPressed: () {
                selectionCubit.clearSelection();
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<MenuItemModel> getSelectionMenuNotesItems(
  context, {
  required SelectionCubit<NoteModel> selectionCubit,
  required NotesCubit notesCubit,
  required List<NoteModel> notes,
}) {
  final selected = selectionCubit.state.selectedItems;
  final allFavorite =
      selected.isNotEmpty && selected.every((n) => n.isFavorite);
  final allArchived =
      selected.isNotEmpty && selected.every((n) => n.isArchived);
  void clearSelection() => selectionCubit.clearSelection();

  return [
    MenuItemModel(
      title: '',
      widget: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: SmartAppColor(context).fillColor,
        ),
        padding: const EdgeInsets.all(8),
        child: Text(
          selected.length.toString(),
          style: AppConstants.bodyLargeStyle(SmartAppColor(context).white),
        ),
      ),
      color: SmartAppColor(context).red,
    ),
    MenuItemModel(
      title: S.of(context).delete,
      icon: IconlyLight.delete,
      color: SmartAppColor(context).red,
      onTap: () {
        notesCubit.deleteNotes(notes);
        clearSelection();
      },
    ),
    MenuItemModel(
      title: allArchived ? S.of(context).un_archive : S.of(context).archive,
      icon: allArchived ? Icons.unarchive_outlined : Icons.archive_outlined,
      color: SmartAppColor(context).grey,
      onTap: () {
        notesCubit.setArchiveForNotes(notes);
        clearSelection();
      },
    ),
    MenuItemModel(
      title: allFavorite ? S.of(context).un_favorites : S.of(context).favorites,
      icon: allFavorite ? Icons.star : Icons.star_border_outlined,
      color: SmartAppColor(context).yellow,
      onTap: () {
        notesCubit.setFavoriteForNotes(notes);
        clearSelection();
      },
    )
  ];
}
