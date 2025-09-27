import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../cubits/top_body_navi/top_body_navi_cubit_.dart';

class PageViewBuilder extends StatelessWidget {
  const PageViewBuilder({
    super.key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        itemCount: AppConstants.homeBodyList.length,
        onPageChanged: (index) {
          context.read<TopBodyNaviCubit>().changeBody(index);
        },
        itemBuilder: (context, index) {
          return AppConstants.homeBodyList[index];
        },
      ),
    );
  }
}
