import 'package:bloc/bloc.dart';

import '../../data/usecase/check_verification_usecase.dart';
import '../../data/usecase/register_user_usecase.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final RegisterUserUseCase _registerUserUseCase;
  final CheckVerificationUseCase _checkVerificationUseCase;

  AuthCubit(this._registerUserUseCase, this._checkVerificationUseCase)
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
    }
  }

  Future<bool> checkEmailVerification() async {
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
      return isVerified;
    } catch (e) {
      emit(AuthFailure("Failed to check email verification: $e"));
      return false;
    }
  }
}
