import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/models/menu_item_model.dart';
import '../../../../../core/widgets/components/components.dart';

class FilterTile extends StatelessWidget {
  final MenuItemModel item;
  final bool selected;
  final VoidCallback onTap;
  final int index;
  final bool customFilter;
  final void Function()? deleteCustomFilter;

  const FilterTile({
    required this.item,
    required this.selected,
    required this.onTap,
    required this.index,
    super.key,
    this.customFilter = false,
    this.deleteCustomFilter,
  });

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.kRadius),
      ),
      selected: selected,
      selectedColor: colors.green,
      selectedTileColor: colors.reverseTextColor,
      leading: customFilter
          ? CircleAvatar(
              backgroundColor: item.color,
              radius: 8.r,
            )
          : Icon(item.icon, color: colors.primary),
      title: Text(
        item.title,
        style: AppConstants.bodyMediumStyle(colors.textPrimary),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: colors.backgroundMuted,
              borderRadius: BorderRadius.circular(AppConstants.kRadius - 6),
              border: Border.all(color: colors.border),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text(
              item.count.toString(),
              style: AppConstants.bodyMediumStyle(colors.textPrimary),
            ),
          ),
          if (customFilter) AppComponents.mediumHorizontalSpace(),
          if (customFilter)
            GestureDetector(
              onTap: () {
                // Handle delete action
                deleteCustomFilter?.call();
              },
              child: Icon(
                Icons.close,
                color: colors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }
}
