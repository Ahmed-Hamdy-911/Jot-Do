import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jot_do/core/constants/constant.dart';
import 'package:jot_do/core/cubits/filterCubit/filter_cubit.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.title,
    required this.filerIndex,
  });
  final String title;
  final int filerIndex;

  @override
  Widget build(BuildContext context) {
    var screenW = MediaQuery.of(context).size.width;
    var segmentCubit = context.read<FilterCubit>();
    bool isSelected =
        context.watch<FilterCubit>().state.filterIndex == filerIndex;
    return OutlinedButton(
        onPressed: () => segmentCubit.switchSegment(filerIndex),
        style: ButtonStyle(
            shadowColor: null,
            padding: WidgetStatePropertyAll(EdgeInsetsDirectional.symmetric(
                horizontal: screenW > 600 ? 60 : 30)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
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
  }
}
