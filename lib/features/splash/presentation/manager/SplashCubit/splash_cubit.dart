import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../auth/data/repository/auth_repo_impl.dart';
import '../../../data/repository/splash_repo.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitialState());

  Widget checkNextScreen() {
    emit(ChangeSplashNavigationState());
    return SplashRepo(AuthRepoImpl()).checkNextScreen();
  }
}
