import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_repository.dart';

class AuthRepoImpl implements AuthRepository {
  var _firebaseAuth = FirebaseAuth.instance;
  @override
  dynamic get user => _firebaseAuth.currentUser;

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
    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException on register from AuthRepo: ${e.code}");
      rethrow;
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
    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException on login from AuthRepo: ${e.code}");
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
        return await _firebaseAuth.signInWithPopup(googleProvider);
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

        return await _firebaseAuth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(
          "FirebaseAuthException on signInWithGoogle from AuthRepo: ${e.code}");
      rethrow;
    } catch (e) {
      debugPrint(
          "Exception on signInWithGoogle from AuthRepo: ${e.toString()}");
      rethrow;
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
      return true;
    }
    return false;
  }
}
