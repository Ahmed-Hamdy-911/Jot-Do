import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_constants.dart';
import '../constants/colors/smart_app_color.dart';
import '../../features/filters/presentation/cubits/pick_color/pick_color_cubit.dart';

class PickColorItem extends StatelessWidget {
  const PickColorItem({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    final selectedColor = context.watch<PickColorCubit>().state.selectedColor;
    final isSelected = selectedColor == color;
    final colors = SmartAppColor(context);
    var screenWidth = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.kRadius),
      ),
      child: InkWell(
        onTap: () => context.read<PickColorCubit>().pickColor(color),
        borderRadius: BorderRadius.circular(AppConstants.kRadius),
        splashColor: color.withValues(alpha: 0.2),
        child: Container(
          width: screenWidth >= 600 ? 40.w : 60.w,
          height: screenWidth >= 600 ? 50.h : 35.h,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(AppConstants.kRadius),
            border: Border.all(
              color: isSelected ? colors.buttonPrimary : colors.transparent,
              width: 2,
            ),
          ),
          child: Center(
            child: CircleAvatar(
              backgroundColor: color,
              radius: 10,
            ),
          ),
        ),
      ),
    );
  }
}
