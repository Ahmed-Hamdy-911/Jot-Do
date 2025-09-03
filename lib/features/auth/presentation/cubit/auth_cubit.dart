import 'package:bloc/bloc.dart';

import '../../data/usecase/check_verification_usecase.dart';
import '../../data/usecase/login_user_usecase.dart';
import '../../data/usecase/register_user_usecase.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final RegisterUserUseCase _registerUserUseCase;
  final LoginUserUseCase _loginUserUseCase;
  final CheckVerificationUseCase _checkVerificationUseCase;

  AuthCubit(this._registerUserUseCase, this._loginUserUseCase,
      this._checkVerificationUseCase)
      : super(AuthInitialState());

  void register({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    try {
      await _registerUserUseCase.call(email: email, password: password);
      emit(AuthEmailVerificationSent(
        "Register successful. Verification email sent. Please verify your email.",
      ));
    } catch (e) {
      emit(AuthFailure("Registration failed: $e"));
      // if (e.toString().contains("email-already-in-use")) {
      //   // emit(LoginWithAlreadyUsedEmail(
      //   //     "The email is already in use by another account."));
      // } else {

      // }
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final isVerified = await _checkVerificationUseCase.call();
    try {
      await _loginUserUseCase
          .call(email: email, password: password)
          .then((va) async {
        if (isVerified) {
          emit(AuthSuccess());
        } else {
          emit(AuthEmailVerificationSent(
              "Email not verified. Please check your inbox."));
        }
      });
      emit(AuthSuccess());
    } catch (e) {
      if (!isVerified) {
        emit(AuthEmailVerificationSent(
            "Email not verified. Please check your inbox."));
      } else {
        emit(AuthFailure("Login failed: $e"));
      }
    }
  }

  Future<void> checkEmailVerification() async {
    emit(AuthLoadingState());
    try {
      final isVerified = await _checkVerificationUseCase.call();
      if (isVerified) {
        emit(AuthEmailVerified());
      } else {
        emit(AuthEmailVerificationSent(
          "Email not verified. Please check your inbox.",
        ));
      }
    } catch (e) {
      emit(AuthFailure("Failed to check email verification: $e"));
    }
  }
}
