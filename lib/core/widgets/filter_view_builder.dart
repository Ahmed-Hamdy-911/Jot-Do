import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jot_do/core/cubits/filterCubit/filter_cubit.dart';
import 'filter_item.dart';

class FilterViewBuilder extends StatelessWidget {
  const FilterViewBuilder({
    super.key,
    required this.filterList,
  });
  final List<dynamic> filterList;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterCubit(),
      child: FilterListView(filterList: filterList),
    );
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
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenWidth > 600 ? screenHeight * 0.09 : screenHeight * 0.067,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
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
