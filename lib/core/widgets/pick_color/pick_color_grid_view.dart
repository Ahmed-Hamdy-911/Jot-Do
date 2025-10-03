import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/filters/presentation/cubits/pick_color/pick_color_state.dart';
import '../../constants/app_constants.dart';
import '../../constants/colors/smart_app_color.dart';
import '../../../features/filters/presentation/cubits/pick_color/pick_color_cubit.dart';
import '../components/components.dart';
import '../../../generated/l10n.dart';
import 'pick_color_item.dart';

class PickColorGridView extends StatelessWidget {
  const PickColorGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    var filterCubit = context.read<PickColorCubit>();
    return BlocBuilder<PickColorCubit, PickColorState>(
      builder: (context, state) {
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
              children: filterCubit.listColors
                  .map((color) => PickColorItem(
                        color: color,
                      ))
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
