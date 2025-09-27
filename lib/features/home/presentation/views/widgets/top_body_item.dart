import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/components.dart';
import '../../../../settings/presentation/cubits/setting_cubit.dart';
import '../../cubits/top_body_navi/top_body_navi_cubit_.dart';

class TopBodyItem extends StatelessWidget {
  const TopBodyItem({
    super.key,
    required this.selectedIndex,
    this.isEndItem = false,
    required this.title,
    required this.pageController,
    required this.icon,
  });
  final int selectedIndex;
  final String title;
  final IconData icon;
  final bool isEndItem;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    bool isSelected = selectedIndex == context.watch<TopBodyNaviCubit>().state;
    bool isArabic =
        context.watch<SettingCubit>().state.locale == const Locale('ar');
    BorderRadius? borderRadius() {
      if (isArabic) {
        return isEndItem
            ? BorderRadius.only(
                topLeft: Radius.circular(AppConstants.kRadius),
                bottomLeft: Radius.circular(AppConstants.kRadius),
              )
            : BorderRadius.only(
                topRight: Radius.circular(AppConstants.kRadius),
                bottomRight: Radius.circular(AppConstants.kRadius),
              );
      } else {
        return isEndItem
            ? BorderRadius.only(
                topRight: Radius.circular(AppConstants.kRadius),
                bottomRight: Radius.circular(AppConstants.kRadius),
              )
            : BorderRadius.only(
                topLeft: Radius.circular(AppConstants.kRadius),
                bottomLeft: Radius.circular(AppConstants.kRadius),
              );
      }
    }

    return Expanded(
      child: InkWell(
        onTap: () {
          context.read<TopBodyNaviCubit>().changeBody(selectedIndex);
          pageController.animateToPage(
            selectedIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        onHighlightChanged: (bool value) {
          if (value) {
            context.read<TopBodyNaviCubit>().changeBody(selectedIndex);
            pageController.animateToPage(
              selectedIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        borderRadius: borderRadius(),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: isSelected
                ? colors.textPrimary.withValues(alpha: 0.2)
                : colors.backgroundSecondary,
            borderRadius: borderRadius(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? colors.primary : colors.textPrimary,
              ),
             AppComponents.smallHorizontalSpace(),
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: isSelected
                    ? AppConstants.bodyMediumStyle(colors.primary)
                    : AppConstants.bodySmallStyle(colors.textPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
