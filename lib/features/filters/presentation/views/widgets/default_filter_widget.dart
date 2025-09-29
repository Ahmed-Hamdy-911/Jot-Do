import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/models/menu_item_model.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/filter/filter_cubit.dart';
import '../../cubits/filter/filter_state.dart';
import 'filter_title.dart';

class DefaultFilterWidget extends StatelessWidget {
  const DefaultFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = SmartAppColor(context);

    final ids = ["all", "new", "favorite", "pinned", "archived"];
    final defaultFilters = [
      MenuItemModel(
          title: S.of(context).filter_all,
          icon: IconlyLight.document,
          onTap: () {},
          count: 0),
      MenuItemModel(
          title: S.of(context).filter_new,
          icon: Icons.new_label_outlined,
          onTap: () {},
          count: 0),
      MenuItemModel(
          title: S.of(context).filter_favorite,
          icon: IconlyLight.star,
          onTap: () {},
          count: 0),
      MenuItemModel(
          title: S.of(context).filter_pined,
          icon: Icons.push_pin_outlined,
          onTap: () {},
          count: 0),
      MenuItemModel(
          title: S.of(context).filter_archived,
          icon: Icons.archive_outlined,
          onTap: () {},
          count: 0),
    ];

    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        final selectedId = state.selectedFilterId ?? ids[0];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).default_filters,
              style: AppConstants.bodyMediumStyle(colors.textSecondary),
            ),
            ListView.builder(
              itemCount: defaultFilters.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final filter = defaultFilters[index];
                final filterId = ids[index];
                return FilterTile(
                  index: index,
                  item: filter,
                  selected: selectedId == filterId,
                  onTap: () {
                    context.read<FilterCubit>().selectFilter(filterId);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
