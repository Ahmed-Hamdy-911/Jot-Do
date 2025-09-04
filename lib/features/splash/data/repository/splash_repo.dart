import 'package:flutter/material.dart';

import '../../../../core/helper/cache_helper.dart';
import '../../../auth/data/domain/auth_repository.dart';
import '../../../auth/presentation/views/emailAndPassword/login_view.dart';
import '../../../home/presentation/views/home_view.dart';

class SplashRepo {
  final AuthRepository authRepository;

  SplashRepo(this.authRepository);

  Widget checkNextScreen() {
    bool onboardingFinished = CacheHelper.getData(key: 'onBoarding') ?? false;
    bool skipAuthentication =
        CacheHelper.getData(key: 'skipAuthentication') ?? false;

    final isLoggedIn = CacheHelper.getData(key: 'isLoggedIn') ?? false;

    if (!onboardingFinished) {
      return const HomeView();
    }

    if (isLoggedIn || skipAuthentication) {
      return const HomeView();
    }

    return const LoginView();
  }
}
