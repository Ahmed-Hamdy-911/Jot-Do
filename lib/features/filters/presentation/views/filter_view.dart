import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/colors/smart_app_color.dart';
import '../../../../core/widgets/components.dart';
import 'widgets/custom_filter_widget.dart';
import 'widgets/default_filter_widget.dart';

class FilterView extends StatelessWidget {
  const FilterView({
    super.key,
    required this.colors,
    required this.title,
    required this.icon,
  });
  final String title;
  final IconData icon;
  final SmartAppColor colors;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.6,
        maxChildSize: 0.95,
        builder: (_, scrollController) {
          return Ink(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: colors.backgroundScreen,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              icon,
                              color: colors.primary,
                            ),
                            AppComponents.mediumHorizontalSpace(),
                            Text(
                              title,
                              style: AppConstants.headlineMediumStyle(
                                  colors.textPrimary),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                AppComponents.smallVerticalSpace(),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const DefaultFilterWidget(),
                        AppComponents.mediumVerticalSpace(),
                        const CustomFilterWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
