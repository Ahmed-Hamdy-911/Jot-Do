import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/helper/cache_helper.dart';
import '../../data/models/user_model.dart';
import '../../data/repository/auth_repository.dart';

import '../../data/repository/user_repo_impl.dart';
import '../../data/repository/user_repository.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository = UserRepoImpl();
  AuthCubit(
    this._authRepository,
  ) : super(AuthInitialState());

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
          createdAt: DateTime.now().toIso8601String());
      await _userRepository.saveUser(user);
      await _authRepository.sendEmailVerification();
      emit(GoVerificationState(
          email: email,
          message: "Verification email sent. Please verify your email."));
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
      await _authRepository.login(email: email, password: password);
      final isVerified = await _authRepository.isEmailVerified();
      if (!isVerified) {
        emit(GoVerificationState(
            email: email,
            message: "Email not verified. Please check your inbox."));
        await _authRepository.sendEmailVerification();
        return;
      } else {
        final isLoggedIn = await _authRepository.checkUserStatus();
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
      final isVerified = await _authRepository.isEmailVerified();
      if (isVerified) {
        final isLoggedIn = await _authRepository.checkUserStatus();
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

  Future<void> resendVerificationEmail() async {
    emit(AuthLoadingState());
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
    try {
      await _authRepository.logout();
      final isLoggedIn = await _authRepository.checkUserStatus();
      CacheHelper.saveData(key: 'isLoggedIn', value: isLoggedIn);
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthFailure("Logout failed"));
    }
  }

  Future<void> forgotPassword({required String email}) async {
    emit(AuthLoadingState());
    try {
      await _authRepository.sendPasswordResetEmail(email: email);
      emit(AuthPasswordResetEmailSent(
          "Password reset email sent. Please check your inbox."));
    } catch (e) {
      emit(AuthFailure("Failed to send password reset email: $e"));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoadingGoogleSignIn());
    try {
      await _authRepository.signInWithGoogle();
      var firebaseUser = _authRepository.user;
      var user = UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email!,
        name: firebaseUser.displayName,
        createdAt: DateTime.now().toIso8601String(),
      );
      await _userRepository.saveUser(user);
      final isLoggedIn = await _authRepository.checkUserStatus();
      CacheHelper.saveData(key: 'isLoggedIn', value: isLoggedIn);
      emit(AuthGoogleSignInSuccess());
    } catch (e) {
      debugPrint("Google sign-in failed: $e");
      emit(AuthGoogleSignInFailure("Google sign-in failed: $e"));
    }
  }
}
