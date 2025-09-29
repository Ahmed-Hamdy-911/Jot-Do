import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/constants/colors/smart_app_color.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/cubits/bottom_sheet_cubit/bottom_sheet_cubit.dart';
import '../../data/models/filter_model.dart';
import '../cubits/filter/filter_cubit.dart';
import '../cubits/filter/filter_state.dart';

class ShowFilterView extends StatelessWidget {
  const ShowFilterView({
    super.key,
    required this.colors,
  
  });

  final SmartAppColor colors;
 

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        final selectedId = state.selectedFilterId;
        final customFilter = state.filters.firstWhere(
          (filter) => filter.id == selectedId,
          orElse: () => FilterModel.empty(),
        );

        String label;
        IconData icon;
        Color color = colors.primary;

        if (customFilter.id.isNotEmpty) {
          label = customFilter.name;
          icon = Icons.circle;
          color = Color(customFilter.color);
        } else {
          switch (selectedId) {
            case "all":
              label = S.of(context).filter_all;
              icon = IconlyLight.document;
              break;
            case "new":
              label = S.of(context).filter_new;
              icon = Icons.new_label_outlined;
              break;
            case "favorite":
              label = S.of(context).filter_favorite;
              icon = IconlyLight.star;
              break;
            case "pinned":
              label = S.of(context).filter_pined;
              icon = Icons.push_pin_outlined;
              break;
            case "archived":
              label = S.of(context).filter_archived;
              icon = Icons.archive_outlined;
              break;
            default:
              label = S.of(context).filter_all;
              icon = IconlyLight.document;
          }
        }

        return OutlinedButton.icon(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(colors.primary),
          ),
          onPressed: () {
            context.read<BottomSheetCubit>().openFilterSheet(
                  context,
                  title: S.of(context).filter_notes,
                  icon: IconlyLight.document,
                );
          },
          icon: Icon(icon,
              size: 20, color: customFilter.id.isNotEmpty ? color : null),
          label: Padding(
            padding: const EdgeInsetsDirectional.only(start: 10.0),
            child: Text(label),
          ),
        );
      },
    );
  }
}
