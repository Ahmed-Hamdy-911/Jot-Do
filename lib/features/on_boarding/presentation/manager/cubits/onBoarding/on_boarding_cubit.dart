import 'package:bloc/bloc.dart';

import '../../../../data/repository/on_boarding_repo.dart';
part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(OnBoardingInitial());

  final onBoardingRepo = OnBoardingRepo();
  int currentIndex = 0;

  void onPageChanged(int index) {
    currentIndex = index;
    emit(OnBoardingPageChanged(index));
  }

  void completeOnBoarding() {
    onBoardingRepo.completeOnBoarding();
    emit(OnBoardingCompleted());
  }

  void skipOnBoarding() {
    onBoardingRepo.skipOnBoarding();
    emit(OnBoardingSkipped());
  }
}
