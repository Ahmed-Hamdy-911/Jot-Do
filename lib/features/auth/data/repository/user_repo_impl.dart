import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helper/cache_helper.dart';
import '../models/user_model.dart';
import 'user_repository.dart';

class UserRepoImpl implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
  String userCollectionName = AppConstants.userCollection;
  Future<void> saveUser(UserModel user) async {
    try {
      await _firestore
          .collection(userCollectionName)
          .doc(user.id)
          .set(user.toJson(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      debugPrint("FirebaseException on saveUser from UserRepo: ${e.code}");
      rethrow;
    } catch (e) {
      debugPrint("Unknown error on saveUser from UserRepo: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(String id) {
    try {
      return Future.error("error");
    } on FirebaseException catch (e) {
      debugPrint("FirebaseException on deleteUser from UserRepo: ${e.code}");
      rethrow;
    } catch (e) {
      debugPrint("Unknown error on deleteUser from UserRepo: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<UserModel?> getUserById(String id) async {
    try {
      final doc = await _firestore.collection(userCollectionName).doc(id).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } on FirebaseException catch (e) {
      debugPrint("FirebaseException on getUserById from UserRepo: ${e.code}");
      rethrow;
    } catch (e) {
      debugPrint("Unknown error on getUserById from UserRepo: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> updateUser(UserModel user) {
    try {
      user.updatedAt = DateTime.now().millisecondsSinceEpoch.toString();
      return _firestore
          .collection(userCollectionName)
          .doc(user.id)
          .set(user.toJson(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      debugPrint("FirebaseException on updateUser from UserRepo: ${e.code}");
      rethrow;
    } catch (e) {
      debugPrint("Unknown error on updateUser from UserRepo: ${e.toString()}");
      rethrow;
    }
  }

  // استمع للتغيير عند بدء التشغيل أو أثناء الجلسة
  final metaDoc = FirebaseFirestore.instance.doc('app_meta/forceLogout');

  void startForceLogoutListener(BuildContext context) {
    metaDoc.snapshots().listen((snapshot) {
      if (!snapshot.exists) return;
      final serverVersion = snapshot.data()?['version'];
      final localVersion = CacheHelper.getData(key: 'forceLogoutVersion') ?? 0;

      if (serverVersion != null && serverVersion != localVersion) {
        // خزَّن النسخة الجديدة محلياً عشان لا ينفذ مره تاني
        CacheHelper.saveData(key: 'forceLogoutVersion', value: serverVersion);
        // افرض تسجيل الخروج
        FirebaseAuth.instance.signOut();
        // خيار: أعرض حوار يطالب المستخدم بإعادة تسجيل الدخول
      }
    });
  }
}
