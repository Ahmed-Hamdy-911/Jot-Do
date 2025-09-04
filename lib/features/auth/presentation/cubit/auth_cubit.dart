import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/helper/cache_helper.dart';
import '../../data/usecase/check_auth_usecase.dart';
import '../../data/usecase/check_verification_usecase.dart';
import '../../data/usecase/forgot_password_usecase.dart';
import '../../data/usecase/login_user_usecase.dart';
import '../../data/usecase/register_user_usecase.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final RegisterUserUseCase _registerUserUseCase;
  final LoginUserUseCase _loginUserUseCase;
  final CheckVerificationUseCase _checkVerificationUseCase;
  final CheckAuthUseCase _checkAuthUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  AuthCubit(
      this._registerUserUseCase,
      this._loginUserUseCase,
      this._checkVerificationUseCase,
      this._checkAuthUseCase,
      this._forgotPasswordUseCase)
      : super(AuthInitialState());

  void register({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    try {
      await _registerUserUseCase.call(email: email, password: password);
      emit(AuthSuccess());
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case "email-already-in-use":
            emit(
                AuthFailure("This email is already in use. Please try again."));
            break;
          case "weak-password":
            emit(AuthFailure("Password is too weak. Please try again."));
            break;
          default:
            emit(AuthFailure("Something went wrong. Please try again."));
        }
      }
      debugPrint("Current state: $state");
      debugPrint("Exception on register from AuthCubit: ${e.toString()}");
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    try {
      await _loginUserUseCase.call(email: email, password: password);
      final isVerified = await _checkVerificationUseCase.call();
      if (!isVerified) {
        emit(AuthEmailVerificationNeeded(
            "Email not verified. Please check your inbox."));
        _loginUserUseCase.sendEmailVerification();
        emit(AuthEmailVerificationSent(
            "Verification email sent. Please verify your email."));
        return;
      } else {
        final isLoggedIn = await _checkAuthUseCase.call();
        CacheHelper.saveData(key: 'isLoggedIn', value: isLoggedIn);
        emit(AuthSuccess());
      }
    } catch (e) {
      emit(AuthFailure("Login failed"));
    }
  }

  Future<void> checkEmailVerification() async {
    emit(AuthVerificationLoading());

    try {
      final isVerified = await _checkVerificationUseCase.call();
      if (isVerified) {
        final isLoggedIn = await _checkAuthUseCase.call();
        CacheHelper.saveData(key: 'isLoggedIn', value: isLoggedIn);
        emit(AuthEmailVerified());
      } else {
        emit(AuthEmailVerificationNeeded(
          "Email not verified. Please check your inbox.",
        ));
      }
    } catch (e) {
      emit(AuthFailure("Failed to check email verification: $e"));
    }
  }

  Future<void> logout() async {
    emit(AuthLoadingState());
    try {
      await _checkAuthUseCase.logout();
      final isLoggedIn = await _checkAuthUseCase.call();
      CacheHelper.saveData(key: 'isLoggedIn', value: isLoggedIn);
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthFailure("Logout failed"));
    }
  }

  Future<void> forgotPassword({required String email}) async {
    emit(AuthLoadingState());
    try {
      await _forgotPasswordUseCase.call(email: email);
      emit(AuthPasswordResetEmailSent(
          "Password reset email sent. Please check your inbox."));
    } catch (e) {
      emit(AuthFailure("Failed to send password reset email: $e"));
    }
  }
}
