import 'package:flutter/material.dart';

import '../../../features/filters/presentation/views/widgets/add_filter.dart';
import '../../../generated/l10n.dart';
import '../../constants/app_constants.dart';
import '../../constants/colors/smart_app_color.dart';

class CustomFilterTitleAndButton extends StatelessWidget {
  const CustomFilterTitleAndButton({
    super.key,
    required this.colors,
    this.isInBottomSheet = false,
    required this.parentContext,
  });
  final SmartAppColor colors;
  final bool isInBottomSheet;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            S.of(context).custom_filters,
            style: AppConstants.bodyMediumStyle(colors.textSecondary),
          ),
        ),
        TextButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return AddFilter(
                 
                    isInBottomSheet: isInBottomSheet, parentContext: parentContext);
              },
            );
          },
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(colors.primary),
            overlayColor: WidgetStatePropertyAll(colors.fillColor),
            surfaceTintColor: WidgetStatePropertyAll(colors.fillColor),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.kRadius - 4),
              ),
            ),
          ),
          label: Text(S.of(context).add_filter),
          icon: const Icon(
            Icons.add,
          ),
        ),
      ],
    );
  }
}
