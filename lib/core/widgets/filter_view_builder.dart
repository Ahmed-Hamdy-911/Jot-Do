import 'package:flutter/material.dart';
import 'filter_item.dart';

class FilterViewBuilder extends StatelessWidget {
  const FilterViewBuilder({
    super.key,
    required this.filterList,
  });
  final List<dynamic> filterList;

  @override
  Widget build(BuildContext context) {
    return FilterListView(filterList: filterList);
  }
}

class FilterListView extends StatelessWidget {
  const FilterListView({
    super.key,
    required this.filterList,
  });

  final List filterList;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenWidth > 600 ? 40 : 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8).copyWith(bottom: 4),
        scrollDirection: Axis.horizontal,
        itemCount: filterList.length,
        itemBuilder: (context, index) => FilterItem(
          filerIndex: index,
          title: filterList[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}
