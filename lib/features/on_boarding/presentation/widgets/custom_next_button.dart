import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../core/constants/constant.dart';
import '../../data/models/on_boarding_model.dart';
import '../manager/cubits/onBoarding/on_boarding_cubit.dart';

class CustomNextButton extends StatelessWidget {
  const CustomNextButton({
    super.key,
    required List<OnBoardingModel> pages,
    required PageController pageController,
  })  : _pages = pages,
        _pageController = pageController;

  final List<OnBoardingModel> _pages;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    double progress = (context.read<OnBoardingCubit>().currentIndex + 1) / 3;
    return GestureDetector(
      onTap: () {
        final cubit = context.read<OnBoardingCubit>();
        int nextIndex = cubit.currentIndex + 1;

        if (nextIndex < _pages.length) {
          _pageController.animateToPage(
            nextIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          cubit.onPageChanged(nextIndex);
        } else {
          cubit.completeOnBoarding();
        }
      },
      child: CircularPercentIndicator(
        radius: 30.0,
        lineWidth: 4.0,
        percent: progress,
        animation: true,
        animationDuration: 300,
        center: Icon(
          Icons.arrow_forward_ios,
          color: AppConstants.colorScheme,
          size: 18,
        ),
        progressColor: AppConstants.colorScheme,
        backgroundColor: Colors.white.withValues(alpha: 0.3),
      ),
    );
  }
}
