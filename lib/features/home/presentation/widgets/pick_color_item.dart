import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/cubits/PickColor/pick_color_cubit.dart';
import '../manager/cubits/PickColor/pick_color_state.dart';
import '../../../../core/constants/constant.dart';

class PickColorItem extends StatelessWidget {
  const PickColorItem({
    super.key,
    required this.color,
    this.onTap,
  });

  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    final isWideScreen = screenWidth > 600;
    return BlocBuilder<PickColorCubit, PickColorState>(
      builder: (context, state) {
        var pickColorCubit = context.watch<PickColorCubit>();
        bool isSelected = pickColorCubit.state.selectedColor == color;
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              onTap:
                  () {
                    context.read<PickColorCubit>().pickColor(color);
                  },
              highlightColor: Colors.white.withValues(alpha: 0.3),
              customBorder: const CircleBorder(),
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  Ink(
                    width:
                        isWideScreen ? screenWidth * 0.05 : screenWidth * 0.11,
                    height:
                        isWideScreen ? screenWidth * 0.05 : screenWidth * 0.11,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                      border: Border.all(
                        color: isSelected
                            ? AppConstants.colorScheme.shade900
                            : Colors.transparent,
                        width: 2.5,
                      ),
                    ),
                  ),
                  if (isSelected)
                    PositionedDirectional(
                      child: CircleAvatar(
                        radius: screenWidth > 600
                            ? screenWidth * 0.01
                            : screenWidth * 0.02,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
