import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../constants/colors/smart_app_color.dart';
import 'components.dart';
import '../../generated/l10n.dart';
import 'pick_color_item.dart';

class PickColorGridView extends StatelessWidget {
  const PickColorGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    // var noteColors = context.read<PickColorCubit>().noteColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).color,
          style: AppConstants.filterStyle(colors.textPrimary),
        ),
        AppComponents.smallVerticalSpace(),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5,
          runSpacing: 5,
          children: colors.filterColors
              .map((color) => PickColorItem(
                    color: color,
                  ))
              .toList(),
        ),
      ],
    );
  }
}
