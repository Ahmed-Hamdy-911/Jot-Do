import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helper/cache_helper.dart';
import '../../../auth/data/repository/auth_repository.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../on_boarding/presentation/views/on_boarding_view.dart';

class SplashRepo {
  final AuthRepository authRepository;

  SplashRepo(this.authRepository);

  Widget checkNextScreen() {
    bool continueWithoutAccount =
        CacheHelper.getData(key: AppConstants.continueWithoutAccount) ?? false;

    final isLoggedIn =
        CacheHelper.getData(key: AppConstants.isLoggedIn) ?? false;

    if (isLoggedIn || continueWithoutAccount) {
      return const HomeView();
    }

    return const OnBoardingView();
  }
}
