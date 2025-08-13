import 'package:flutter/material.dart';
import 'package:jot_do/core/constants/constant.dart';

class SegmentedControl extends StatelessWidget {
  const SegmentedControl({
    super.key,
    required this.title,
    this.isSelected = false,
    this.borderColor,
  });
  final String title;
  final bool isSelected;

  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    var screenW = MediaQuery.of(context).size.width;
    return OutlinedButton(
        onPressed: () {},
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
                color: borderColor ?? Colors.grey[800]!,
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(
                isSelected ? AppConstants.mainLightColor : Colors.white)),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppConstants.colorScheme : Colors.grey[800]!,
            fontSize: screenW > 600 ? 18 : 15,
          ),
        ));
  }
}
