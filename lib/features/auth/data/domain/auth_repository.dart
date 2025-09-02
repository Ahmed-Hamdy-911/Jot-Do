abstract class AuthRepository {
  Future<void> register({
    required String email,
    required String password,
  });
  Future<void> login({
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<void> sendEmailVerification();
  Future<bool> isEmailVerified();
}
