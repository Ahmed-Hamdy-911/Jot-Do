import '../../../../core/helper/cache_helper.dart';

class OnBoardingRepo {
  void finishOnBoarding() {
    CacheHelper.saveData(key: 'onBoarding', value: true);
  }

  void completeOnBoarding() => finishOnBoarding();
  void skipOnBoarding() => finishOnBoarding();
}
