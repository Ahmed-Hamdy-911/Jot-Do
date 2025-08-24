import 'package:flutter/material.dart';

import '../../../../core/helper/cache_helper.dart';
import '../../../auth/presentation/views/emailAndPassword/login_view.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../on_boarding/presentation/views/on_boarding_view.dart';

class SplashRepo {

  static Widget afterSplash() {
    bool onboardingFinished = CacheHelper.getData(key: 'onBoarding') ?? false;
    bool skipAuthentication =
        CacheHelper.getData(key: 'skipAuthentication') ?? false;
    if (onboardingFinished == true && skipAuthentication == true) {
      return const HomeView();
    } else if (onboardingFinished == true) {
      return const LoginView();
    } else {
      return const OnBoardingView();
    }
  }
}
