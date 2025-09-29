import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/filters/presentation/views/show_filter_view.dart';
import '../constants/colors/smart_app_color.dart';
import 'components.dart';
import '../constants/app_constants.dart';
import 'custom_material_button.dart';
import '../../features/home/presentation/cubits/top_body_navi/top_body_navi_cubit_.dart';

class FilterAndChangeView extends StatelessWidget {
  const FilterAndChangeView({
    super.key,
    required this.isInNotes,
  
    
  });

  final bool isInNotes;
  
  @override
  Widget build(BuildContext context) {
    bool isInNotes = context.watch<TopBodyNaviCubit>().state == 0;
    var colors = SmartAppColor(context);
    bool platform =
        kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS
            ? true
            : false;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ShowFilterView(
          colors: colors,
         
        ),
        Row(
          children: [
            if (!platform)
              CustomMaterialButton(
                height: 25.h,
                minWidth: 20.w,
                radius: AppConstants.kRadius - 4,
                color: isInNotes ? colors.primary : colors.backgroundScreen,
                onPressed: () {},
                widget: Icon(
                  Icons.list,
                  size: 25,
                  color: isInNotes
                      ? colors.backgroundSecondary
                      : colors.textSecondary,
                ),
              ),
            AppComponents.smallHorizontalSpace(),
            CustomMaterialButton(
              height: 25.h,
              minWidth: 20.w,
              onPressed: () {},
              radius: AppConstants.kRadius - 4,
              color: platform
                  ? colors.primary
                  : isInNotes
                      ? colors.backgroundScreen
                      : colors.primary,
              widget: Icon(
                Icons.grid_view_outlined,
                color: platform
                    ? colors.backgroundSecondary
                    : isInNotes
                        ? colors.textSecondary
                        : colors.backgroundSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
