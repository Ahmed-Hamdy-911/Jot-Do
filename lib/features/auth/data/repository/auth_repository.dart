abstract class AuthRepository {
  Future<void> register({required String email, required String password});
  Future<void> login({required String email, required String password});
  Future<void> signInWithGoogle();
  Future<void> logout();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordResetEmail({required String email});
  Future<bool> isEmailVerified();
  Future<bool> checkUserStatus();
  dynamic get user;
}
