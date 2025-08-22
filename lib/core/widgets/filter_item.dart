import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/constant.dart';
import '../cubits/selectionCubit/selection_cubit.dart';

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
    var segmentCubit = context.read<SelectionCubit>();
    bool isSelected =
        context.watch<SelectionCubit>().state.selectedIndex == filerIndex;
    return OutlinedButton(
        onPressed: () {
          segmentCubit.switchSelection(filerIndex);
        },
        style: ButtonStyle(
            shadowColor: null,
            padding: WidgetStatePropertyAll(EdgeInsetsDirectional.symmetric(
              horizontal: screenW > 600 ? 60 : 30,
            )),
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
            fontSize: screenW > 600 ? 17 : 14,
          ),
        ));
  }
}
