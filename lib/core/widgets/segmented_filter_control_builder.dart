import 'package:flutter/material.dart';
import 'segmented_filter_control_widget.dart';

class SegmentedFilterControlBuilder extends StatelessWidget {
  const SegmentedFilterControlBuilder({
    super.key,
    required this.segmentList,
  });
  final List<dynamic> segmentList;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenWidth > 600 ? screenHeight * 0.09 : screenHeight * 0.067,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: segmentList.length,
        itemBuilder: (context, index) => SegmentedControl(
          title: segmentList[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}
