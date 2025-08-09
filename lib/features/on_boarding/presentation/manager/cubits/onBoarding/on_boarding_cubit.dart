import 'package:bloc/bloc.dart';
part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(OnBoardingInitial());

  int currentIndex = 0;

  void onPageChanged(int index) {
    currentIndex = index;
    emit(OnBoardingPageChanged(index));
  }

  void completeOnBoarding() {
    emit(OnBoardingCompleted());
  }

  void skipOnBoarding() {
    emit(OnBoardingSkipped());
  }
}
