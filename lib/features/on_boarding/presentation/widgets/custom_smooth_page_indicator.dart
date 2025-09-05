import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/on_boarding_model.dart';

class CustomSmoothPageIndicator extends StatelessWidget {
  const CustomSmoothPageIndicator({
    super.key,
    required PageController pageController,
    required List<OnBoardingModel> pages,
  })  : _pageController = pageController,
        _pages = pages;

  final PageController _pageController;
  final List<OnBoardingModel> _pages;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SmoothPageIndicator(
          controller: _pageController,
          onDotClicked: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
          },
          count: _pages.length,
          effect: const WormEffect(
              spacing: 8.0,
              dotHeight: 12,
              dotWidth: 12,
              dotColor: Colors.white70,
              activeDotColor: AppColor.colorScheme),
        ),
      ),
    );
  }
}
