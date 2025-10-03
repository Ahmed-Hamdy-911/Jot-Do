import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../features/filters/presentation/views/show_filter_view.dart';
import '../../constants/colors/smart_app_color.dart';
import '../../cubits/layout_cubit.dart';
import '../components/components.dart';
import '../../constants/app_constants.dart';

class FilterAndChangeView extends StatelessWidget {
  const FilterAndChangeView({super.key, required this.isInNotes});

  final bool isInNotes;

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    bool platform =
        kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS;

    var layoutCubit = context.watch<LayoutCubit>();
    var layoutType = layoutCubit.state;

    return Container(
      height: 35.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShowFilterView(colors: colors),
          Row(
            children: [
              // LIST VIEW ICON
              CircleAvatar(
                backgroundColor: layoutType == LayoutType.list
                    ? colors.reverseBackgroundColor
                    : colors.backgroundScreen,
                child: IconButton(
                  onPressed: () =>
                      context.read<LayoutCubit>().toggleLayout(LayoutType.list),
                  icon: Icon(
                    Icons.list,
                    size: AppConstants.scaledSp(20),
                    color: layoutType == LayoutType.list
                        ? colors.backgroundScreen
                        : colors.textSecondary,
                  ),
                ),
              ),
              AppComponents.smallHorizontalSpace(),

              // GRID VIEW ICON
              if (platform || !isInNotes)
                CircleAvatar(
                  backgroundColor: layoutType == LayoutType.grid
                      ? colors.reverseBackgroundColor
                      : colors.backgroundScreen,
                  child: IconButton(
                    onPressed: () => context
                        .read<LayoutCubit>()
                        .toggleLayout(LayoutType.grid),
                    icon: Icon(
                      Icons.grid_view_outlined,
                      size: AppConstants.scaledSp(20),
                      color: layoutType == LayoutType.grid
                          ? colors.backgroundScreen
                          : colors.textSecondary,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
