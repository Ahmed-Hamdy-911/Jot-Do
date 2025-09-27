import 'package:flutter/material.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../generated/l10n.dart';
import 'package:iconly/iconly.dart';
import '../../../../../core/models/menu_item_model.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    super.key,
    required this.currentPage,
  });
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return FloatingActionButton(
      backgroundColor: colors.reverseBackgroundColor.withValues(alpha: 0.8),
      foregroundColor: colors.textInverse,
      onPressed: () {
        if (currentPage == 0) {
          Navigator.pushNamed(context, AppRoutes.addNote);
        } else {
          Navigator.pushNamed(context, AppRoutes.addTask);
        }
      },
      shape: const CircleBorder(),
      tooltip: S.of(context).add_note_or_task,
      child: const Icon(Icons.add),
    );
  }
}

List<MenuItemModel> defaultFilters = [
  MenuItemModel(
    title: S.current.filter_all,
    icon: IconlyLight.document,
    onTap: () {},
    count: 0,
  ),
  MenuItemModel(
    title: S.current.filter_favorite,
    icon: IconlyLight.star,
    onTap: () {},
    count: 0,
  ),
  MenuItemModel(
    title: S.current.filter_pined,
    icon: Icons.push_pin_outlined,
    onTap: () {},
    count: 0,
  ),
  MenuItemModel(
    title: S.current.filter_archived,
    icon: Icons.archive_outlined,
    onTap: () {},
    count: 0,
  ),
];
