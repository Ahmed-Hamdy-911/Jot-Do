import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jot_do/core/constants/constant.dart';
import 'package:jot_do/core/cubits/filterCubit/filter_cubit.dart';
import 'package:jot_do/core/cubits/filterCubit/filter_state.dart';

class SegmentedControl extends StatelessWidget {
  const SegmentedControl({
    super.key,
    required this.title,
    required this.segmentIndex,
  });
  final String title;
  final int segmentIndex;

  @override
  Widget build(BuildContext context) {
    var screenW = MediaQuery.of(context).size.width;
    var segmentCubit = context.read<FilterCubit>();

    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        bool isSelected = state.filterIdex == segmentIndex;
        return OutlinedButton(
            onPressed: () => segmentCubit.switchSegment(segmentIndex),
            style: ButtonStyle(
                shadowColor: null,
                padding: WidgetStatePropertyAll(EdgeInsetsDirectional.symmetric(
                    horizontal: screenW > 600 ? 60 : 30)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        screenW > 600 ? screenW * 0.008 : screenW * 0.02),
                  ),
                ),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: isSelected ? Colors.transparent : Colors.grey[800]!,
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(
                    isSelected ? AppConstants.mainLightColor : Colors.white)),
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white70 : Colors.grey[800]!,
                fontSize: screenW > 600 ? 18 : 15,
              ),
            ));
      },
    );
  }
}
