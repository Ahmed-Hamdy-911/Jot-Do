part of 'on_boarding_cubit.dart';

abstract class OnBoardingStates {}

class OnBoardingInitial extends OnBoardingStates {}

class OnBoardingCompleted extends OnBoardingStates {}

class OnBoardingSkipped extends OnBoardingStates {}

class OnBoardingPageChanged extends OnBoardingStates {
  final int index;

  OnBoardingPageChanged(this.index);
}
