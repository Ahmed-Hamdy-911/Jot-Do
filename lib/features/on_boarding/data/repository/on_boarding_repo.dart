import '../../../../core/helper/cache_helper.dart';

class OnBoardingRepo {
  final cacheHelper = CacheHelper();
  void finishOnBoarding() {
    cacheHelper.saveData(key: 'onBoarding', value: true);
  }

  void completeOnBoarding() => finishOnBoarding();
  void skipOnBoarding() => finishOnBoarding();
}
