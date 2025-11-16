import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/services/app_session.dart';
import 'auth_repository.dart';

class AuthRepoImpl implements AuthRepository {
  var _firebaseAuth = FirebaseAuth.instance;
  @override
  dynamic get user => _firebaseAuth.currentUser!;
  final _session = AppSession.instance;
  // Define your authentication methods here
  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    // Implement registration logic
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _session.setLoginStatus(true);
      await _session.setUid(_firebaseAuth.currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException on register from AuthRepo: ${e.code}");
      if (e.code == "network-request-failed") {
        throw ("No internet connection");
      }

      switch (e.code) {
        case "email-already-in-use":
          throw ("This email is already in use. Please try again.");

        case "weak-password":
          throw ("Password is too weak. Please try again.");

        default:
          throw ("Something went wrong. Please try again.");
      }
    } on TimeoutException catch (_) {
      throw ("No internet connection");
    } catch (e) {
      debugPrint("Exception on register from AuthRepo: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    // Implement login logic
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _session.setLoginStatus(true);
      await _session.setUid(_firebaseAuth.currentUser!.uid);
    } on TimeoutException catch (_) {
      throw ("Time out No internet connection");
    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException on login from AuthRepo: ${e.code}");
      if (e.code == "network-request-failed") {
        throw ("No internet connection");
      }
      rethrow;
    } catch (e) {
      debugPrint("Exception on login from AuthRepo: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        await _session.setLoginStatus(true);
        return await _firebaseAuth.signInWithPopup(googleProvider);
      } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        throw UnimplementedError(
            "Google Sign-In not supported on this platform.");
      } else {
        final GoogleSignIn googleSignIn = GoogleSignIn.instance;

        await googleSignIn.initialize(
          serverClientId:
              "73016899489-s5tdbae62pm8ofu3ple9f98e67pb6j52.apps.googleusercontent.com",
        );

        final GoogleSignInAccount? account = await googleSignIn.authenticate();
        if (account == null) return null;

        final GoogleSignInAuthentication googleAuth =
            await account.authentication;
        if (googleAuth.idToken == null) return null;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );
        // await  _session.setUid(_firebaseAuth.currentUser!.uid);
        final result = await _firebaseAuth.signInWithCredential(credential);
        await _session.setLoginStatus(true);
        await _session.setUid(_firebaseAuth.currentUser!.uid);
        // log('[TEST] after google sign-in: isLoggedIn=${AppSession.instance.isLoggedIn}, uid=${AppSession.instance.uid}');
        return result;
      }
    } on GoogleSignInException catch (e) {
      debugPrint(
          "GoogleSignInException on signInWithGoogle from AuthRepo: ${e.code}");
      if (e.code == "network-request-failed") {
        throw ("No internet connection");
      }
      if (e.code == "GoogleSignInExceptionCode.canceled") {
        return null;
      } else if (e.code == "GoogleSignInExceptionCode.networkError") {
        throw ("No internet connection");
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<void> logout() async {
    // Implement sign-out logic
    try {
      var user = _firebaseAuth.currentUser;
      var googleUser = GoogleSignIn.instance;
      if (user != null) {
        await _firebaseAuth.signOut();
      } else {
        await googleUser.disconnect();
        await googleUser.signOut();
      }
      await _session.logout();
    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException on sign out from AuthRepo: ${e.code}");
      if (e.code == "network-request-failed") {
        throw ("No internet connection");
      }
      if (e.code == "NetworkError") {
        throw ("No internet connection");
      }
      rethrow;
    } catch (e) {
      debugPrint("Exception on sign out from AuthRepo: ${e.toString()}");
      rethrow;
    }
  }

  Future<void> sendEmailVerification() async {
    // Implement email verification logic
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      debugPrint(
          "Exception on sendEmailVerification from AuthRepo: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      debugPrint(
          "FirebaseAuthException on sendPasswordResetEmail from AuthRepo: ${e.code}");
      if (e.code == "network-request-failed") {
        throw ("No internet connection");
      }
      rethrow;
    } catch (e) {
      debugPrint(
          "Exception on sendPasswordResetEmail from AuthRepo: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<bool> isEmailVerified() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.reload();
      return user.emailVerified;
    }
    return false;
  }

  @override
  Future<bool> checkUserStatus() async {
    final user = _firebaseAuth.currentUser;
    if (user != null && user.emailVerified) {
      AppSession.instance.setLoginStatus(true);
      return true;
    }
    AppSession.instance.setLoginStatus(false);
    return false;
  }
}
