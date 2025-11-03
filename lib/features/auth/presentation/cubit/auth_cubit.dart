import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/helper/cache_helper.dart';
import '../../../../core/helper/secure_storage_helper.dart';
import '../../../../core/services/app_session.dart';
import '../../data/models/user_model.dart';
import '../../data/repository/auth_repository.dart';

import '../../data/repository/cache_auth_repo.dart';
import '../../data/repository/user_repo_impl.dart';
import '../../data/repository/user_repository.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepository _authRepository;
  final _appSession = AppSession.instance;
  bool get _isOnline => _appSession.isOnline;
  final UserRepository _userRepository = UserRepoImpl();
  AuthCubit(
    this._authRepository,
  ) : super(AuthInitialState());
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool rememberMe = false;
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

  void continueWithoutAccount() {
    CacheAuthRepo.continueWithoutAccount();
    emit(AuthContinueWithoutAccount());
  }

  void reLogin() {
    CacheAuthRepo.reLogin();
    emit(AuthReLogin());
  }

  void register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    if (_isOnline == false) {
      emit(AuthFailure("No internet connection"));
      return;
    }
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
    if (_isOnline == false) {
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
      // log("isOnline: ${_isOnline}");
      final isLoggedIn = await _authRepository.checkUserStatus();
      _appSession.setLoginStatus(isLoggedIn);

      if (rememberMe) {
        SecureStorageHelper.write(key: 'userEmail', value: email);
        SecureStorageHelper.write(key: 'userPassword', value: password);
      } else {
        SecureStorageHelper.write(key: 'userEmail', value: null);
        SecureStorageHelper.write(key: 'userPassword', value: null);
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
    if (_isOnline == false) {
      emit(AuthFailure("No internet connection"));
      return;
    }
    try {
      final isVerified = await _authRepository.isEmailVerified();
      if (isVerified) {
        final isLoggedIn = await _authRepository.checkUserStatus();
        _appSession.setLoginStatus(isLoggedIn);
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
    if (_isOnline == false) {
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
    if (_isOnline == false) {
      emit(AuthFailure("No internet connection"));
      return;
    }
    try {
      await _authRepository.logout();

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
    if (_isOnline == false) {
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
    if (_isOnline == false) {
      emit(AuthFailure("No internet connection"));
      return;
    }
    try {
      await _authRepository.signInWithGoogle();
      var firebaseUser = _authRepository.user;
      await _appSession.setUid(firebaseUser.uid);

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
      await _appSession.setLoginStatus(isLoggedIn);
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
