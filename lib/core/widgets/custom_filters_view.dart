import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/filters/presentation/cubits/filter/filter_cubit.dart';
import '../../features/filters/presentation/cubits/filter/filter_state.dart';
import '../constants/app_constants.dart';
import '../constants/colors/smart_app_color.dart';
import 'components.dart';
import 'filter_title_and_button.dart';

class CustomFiltersView extends StatelessWidget {
  const CustomFiltersView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    var screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        AppComponents.customDivider(15),
        AppComponents.smallVerticalSpace(),
        CustomFilterTitleAndButton(
            colors: colors, isInBottomSheet: false, parentContext: context),
        BlocBuilder<FilterCubit, FilterState>(
          builder: (context, state) {
            final customFilters = [...state.filters]
              ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
            if (customFilters.isEmpty) {
              return const SizedBox.shrink();
            }
            return Container(
              height: 50.h,
              width: screenWidth,
              padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: colors.fillColor,
                borderRadius: BorderRadius.circular(AppConstants.kRadius),
              ),
              child: ListView.builder(
                itemCount: customFilters.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final filter = customFilters[index];
                  final isSelected = filter.id == state.selectedFilterId;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      backgroundColor: colors.backgroundScreen,
                      selectedColor: Color(customFilters[index].color)
                          .withValues(alpha: 0.3),
                      onDeleted: () {
                        context.read<FilterCubit>().deleteFilter(filter.id);
                      },
                      deleteIconColor: colors.textPrimary,
                      deleteIcon: Icon(Icons.close,
                          size: 18, color: colors.textPrimary),
                      label: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 12,
                            color: Color(filter.color),
                          ),
                          AppComponents.largeHorizontalSpace(),
                          Text(
                            filter.name,
                            style:
                                AppConstants.bodySmallStyle(colors.textPrimary),
                          ),
                        ],
                      ),
                      selected: isSelected,
                      selectedShadowColor: colors.textPrimary,
                      onSelected: (_) {
                        context.read<FilterCubit>().selectFilter(
                              isSelected ? null : filter.id,
                            );
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
        AppComponents.smallVerticalSpace(),
      ],
    );
  }
}
