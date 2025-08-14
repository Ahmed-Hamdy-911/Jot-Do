import 'package:flutter/material.dart';
import '../../../../core/constants/constant.dart';
import 'pick_color_item.dart';

class PickColorGridView extends StatelessWidget {
  const PickColorGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isWideScreen = screenWidth > 600;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12),
      child: SizedBox(
        height: isWideScreen ? screenWidth * 0.05 : screenWidth * 0.2,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: AppConstants.noteColors.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isWideScreen ? 1 : 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return PickColorItem(
              color: AppConstants.noteColors[index],
              colorIndex: index,
            );
          },
        ),
      ),
    );
  }
}
