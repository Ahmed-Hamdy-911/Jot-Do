import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/on_boarding_model.dart';
import '../manager/cubits/onBoarding/on_boarding_cubit.dart';
import 'on_boarding_item.dart';

class PageViewBuilder extends StatelessWidget {
  const PageViewBuilder({
    super.key,
    required PageController pageController,
    required List<OnBoardingModel> pages,
  })  : _pageController = pageController,
        _pages = pages;

  final PageController _pageController;
  final List<OnBoardingModel> _pages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (index) {
          context.read<OnBoardingCubit>().onPageChanged(index);
        },
        itemBuilder: (context, index) {
          final page = _pages[index];
          return buildOnBoardingPage(
            context,
            title: page.title,
            description: page.description,
            image: page.image,
          );
        },
      ),
    );
  }
}
