import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../domain/auth_repository.dart';

class AuthRepoImpl implements AuthRepository {
  var _firebaseAuth = FirebaseAuth.instance;

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
  Future<void> logout() async {
    // Implement sign-out logic
    try {
      await _firebaseAuth.signOut();
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
  Future<bool> isEmailVerified() async {
    final user = _firebaseAuth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }
}
