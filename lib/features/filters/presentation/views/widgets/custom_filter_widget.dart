import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/models/menu_item_model.dart';
import '../../../../../core/widgets/filter/filter_title_and_button.dart';
import '../../cubits/filter/filter_cubit.dart';
import '../../cubits/filter/filter_state.dart';
import 'filter_title.dart';

class CustomFilterWidget extends StatefulWidget {
  const CustomFilterWidget({
    super.key,
  });

  @override
  State<CustomFilterWidget> createState() => _CustomFilterBuilderState();
}

class _CustomFilterBuilderState extends State<CustomFilterWidget> {
  @override
  void initState() {
    context.read<FilterCubit>().loadFilters();
    super.initState();
  }

  void onFilterTap(String filterId) {
    context.read<FilterCubit>().selectFilter(filterId);
    // context.read<NotesCubit>().getNotes(filterId);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);

    return Column(
      children: [
        CustomFilterTitleAndButton(
            colors: colors, isInBottomSheet: true, parentContext: context),
        BlocBuilder<FilterCubit, FilterState>(builder: (context, state) {
          final customFilters = [...state.filters]
            ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
          if (customFilters.isEmpty) {
            return const SizedBox.shrink();
          }
          return ListView.builder(
            itemCount: customFilters.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final filter = customFilters[index];
              final filterId = filter.id;
              return FilterTile(
                index: index,
                customFilter: true,
                deleteCustomFilter: () {
                  context.read<FilterCubit>().deleteFilter(filter.id);
                },
                item: MenuItemModel(
                  title: filter.name,
                  color: Color(filter.color),
                  count: 0,
                  onTap: () {
                    onFilterTap(filterId);
                  },
                ),
                selected: state.selectedFilterId == filterId,
                onTap: () {
                  onFilterTap(filterId);
                },
              );
            },
          );
        }),
      ],
    );
  }
}
