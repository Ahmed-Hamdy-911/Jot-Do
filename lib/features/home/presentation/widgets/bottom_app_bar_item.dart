import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/constant.dart';
import '../manager/cubits/BottomNaviCubit/bottom_navi_cubit_cubit.dart';

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
            borderRadius: BorderRadius.circular(16),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: isSelected
                    ? LinearGradient(
                        begin: AlignmentDirectional.centerStart,
                        end: AlignmentDirectional.centerEnd,
                        colors: AppConstants.splashColorsList,
                      )
                    : null,
              ),
              child: Tooltip(
                message: title,
                waitDuration: Duration(milliseconds: 500),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  splashColor: Colors.amber.withOpacity(0.25),
                  onTap: () => context
                      .read<BottomNaviCubit>()
                      .changeBottomPage(pageIndex),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      children: [
                        Icon(
                          isSelected ? iconSelected : iconUnSelected,
                          color: isSelected
                              ? Colors.white
                              : AppConstants.mainDarkColor.withOpacity(0.9),
                          size: isSelected ? 30 : 28,
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: isSelected ? 18 : 16,
                            color: isSelected
                                ? Colors.white
                                : AppConstants.mainDarkColor.withOpacity(0.9),
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
