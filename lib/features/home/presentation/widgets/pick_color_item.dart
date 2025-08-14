import 'package:flutter/material.dart';
import '../../../../core/constants/constant.dart';

class PickColorItem extends StatelessWidget {
  const PickColorItem({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    final isWideScreen = screenWidth > 600;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () {},
          highlightColor: Colors.white.withOpacity(0.3),
          customBorder: const CircleBorder(),
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Ink(
                width: isWideScreen ? screenWidth * 0.05 : screenWidth * 0.11,
                height: isWideScreen ? screenWidth * 0.05 : screenWidth * 0.11,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  border: Border.all(
                    color: AppConstants.colorScheme.shade900,
                    width: 2.5,
                  ),
                ),
              ),
              PositionedDirectional(
                child: CircleAvatar(
                  radius: screenWidth > 600
                      ? screenWidth * 0.01
                      : screenWidth * 0.02,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
