import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../manager/cubits/bottom_navi/bottom_navi_cubit_cubit.dart';

class BottomAppBarItem extends StatelessWidget {
  const BottomAppBarItem({
    super.key,
    required this.title,
    required this.pageIndex,
    required this.iconSelected,
    required this.iconUnSelected,
  });

  final IconData iconSelected;
  final IconData iconUnSelected;
  final String title;
  final int pageIndex;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    return BlocBuilder<BottomNaviCubit, int>(
      builder: (context, state) {
        bool isSelected = state == pageIndex;
        return Expanded(
          child: Material(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(AppConstants.kRadius),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.kRadius),
                gradient: isSelected
                    ? LinearGradient(
                        begin: AlignmentDirectional.centerStart,
                        end: AlignmentDirectional.centerEnd,
                        colors: AppColor.splashColorsList,
                      )
                    : null,
              ),
              child: Tooltip(
                message: title,
                waitDuration: const Duration(milliseconds: 500),
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppConstants.kRadius),
                  splashColor: Colors.amber.withValues(alpha: 0.25),
                  onTap: () => context
                      .read<BottomNaviCubit>()
                      .changeBottomPage(pageIndex),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      mainAxisAlignment: screenWidth > 600
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      children: [
                        Icon(
                          isSelected ? iconSelected : iconUnSelected,
                          color: isSelected
                              ? Colors.white
                              : AppColor.mainDarkColor.withValues(alpha: 0.9),
                          size: isSelected ? 28 : 26,
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: isSelected ? 17 : 15,
                            color: isSelected
                                ? Colors.white
                                : AppColor.mainDarkColor.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
