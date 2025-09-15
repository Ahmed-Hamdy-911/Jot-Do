import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/cubits/connectivity/connection_cubit.dart';
import '../../../../core/helper/cache_helper.dart';
import '../../data/models/user_model.dart';
import '../../data/repository/auth_repository.dart';

import '../../data/repository/user_repo_impl.dart';
import '../../data/repository/user_repository.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository = UserRepoImpl();
  final ConnectionCubit connectionCubit = ConnectionCubit();
  AuthCubit(
    this._authRepository,
  ) : super(AuthInitialState());
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool rememberMe = false;
  Future<bool> get hasInternet => connectionCubit.checkConnection();
  void toggleRememberMe(bool value) {
    rememberMe = value;
    CacheHelper.saveData(key: 'rememberMe', value: value);
    emit(AuthRememberMeChanged(rememberMe));
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(AuthTogglePasswordVisibility());
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(AuthToggleConfirmPasswordVisibility());
  }

  void resetPasswordVisibility() {
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
    emit(AuthInitialState());
  }

  void register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    try {
      await _authRepository.register(email: email, password: password);
      var user = UserModel(
          id: _authRepository.user.uid!,
          email: email,
          name: name,
          createdAt: DateTime.now().millisecondsSinceEpoch.toString());
      await _userRepository.saveUser(user);
      await _authRepository.sendEmailVerification();
      emit(GoVerificationState(
          email: email,
          message: "Verification email sent. Please verify your email."));
    } catch (e) {
      debugPrint("Exception on register from AuthCubit: ${e.toString()}");
      if (e.toString().contains("No internet connection")) {
        emit(AuthFailure("No internet connection"));
      }
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    if (!await hasInternet) {
      emit(AuthFailure("No internet connection"));
      return;
    }
    try {
      await _authRepository.login(email: email, password: password);
      final isVerified = await _authRepository.isEmailVerified();

      if (!isVerified) {
        emit(GoVerificationState(
          email: email,
          message: "Email not verified. Please check your inbox.",
        ));
        await _authRepository.sendEmailVerification();
        return;
      }

      final isLoggedIn = await _authRepository.checkUserStatus();
      CacheHelper.saveData(key: AppConstants.isLoggedIn, value: isLoggedIn);

      if (rememberMe) {
        CacheHelper.saveData(key: 'userEmail', value: email);
        CacheHelper.saveData(key: 'userPassword', value: password);
      } else {
        CacheHelper.saveData(key: 'userEmail', value: null);
        CacheHelper.saveData(key: 'userPassword', value: null);
      }

      emit(AuthSuccess());
    } catch (e) {
      if (e.toString().contains("No internet connection")) {
        emit(AuthFailure("No internet connection"));
      } else {
        emit(AuthFailure("Login failed"));
      }
    }
  }

  Future<void> checkEmailVerification() async {
    emit(AuthVerificationLoading());
    if (!await hasInternet) {
      emit(AuthFailure("No internet connection"));
      return;
    }
    try {
      final isVerified = await _authRepository.isEmailVerified();
      if (isVerified) {
        final isLoggedIn = await _authRepository.checkUserStatus();
        CacheHelper.saveData(key: AppConstants.isLoggedIn, value: isLoggedIn);
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

  Future<void> resendVerificationEmail() async {
    emit(AuthLoadingState());
    if (!await hasInternet) {
      emit(AuthFailure("No internet connection"));
      return;
    }
    try {
      await _authRepository.sendEmailVerification();
      emit(AuthEmailVerificationSent(
          "Verification email resent. Please check your inbox."));
    } catch (e) {
      emit(AuthFailure("Failed to resend verification email: $e"));
    }
  }

  Future<void> logout() async {
    emit(AuthLoadingState());
    if (!await hasInternet) {
      emit(AuthFailure("No internet connection"));
      return;
    }
    try {
      await _authRepository.logout();
      CacheHelper.saveData(key: AppConstants.isLoggedIn, value: false);
      emit(AuthLoggedOut());
    } catch (e) {
      if (e.toString().contains("No internet connection")) {
        emit(AuthFailure("No internet connection"));
      }
      emit(AuthFailure("Logout failed"));
    }
  }

  Future<void> forgotPassword({required String email}) async {
    emit(AuthLoadingState());
    if (!await hasInternet) {
      emit(AuthFailure("No internet connection"));
      return;
    }
    try {
      await _authRepository.sendPasswordResetEmail(email: email);
      emit(AuthPasswordResetEmailSent(
          "Password reset email sent. Please check your inbox."));
    } catch (e) {
      emit(AuthFailure("Failed to send password reset email: $e"));
    }
  }

  Future<void> signInWithGoogle() async {
    emit((AuthLoadingGoogleSignIn()));
    if (!await hasInternet) {
      emit(AuthFailure("No internet connection"));
      return;
    }
    try {
      await _authRepository.signInWithGoogle();
      var firebaseUser = _authRepository.user;

      // check if user exists
      var existingUser = await _userRepository.getUserById(firebaseUser.uid);

      if (existingUser == null) {
        // user not found -> create new one
        var newUser = UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email!,
          name: firebaseUser.displayName,
          createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        );
        await _userRepository.saveUser(newUser);
      } else {}

      final isLoggedIn = await _authRepository.checkUserStatus();
      CacheHelper.saveData(key: AppConstants.isLoggedIn, value: isLoggedIn);
      emit(AuthGoogleSignInSuccess());
    } catch (e) {
      debugPrint("Google sign-in failed: $e");
      if (e.toString().contains("GoogleSignInExceptionCode.canceled")) {
        emit(AuthGoogleSignInCanceled());
        return;
      } else if (e
          .toString()
          .contains(" GoogleSignInExceptionCode.networkError")) {
        emit(AuthGoogleSignInFailure("No internet connection"));
      } else {
        emit(AuthGoogleSignInFailure("Google sign-in failed: $e"));
      }
    }
  }
}
