import '../domain/auth_repository.dart';

class SocialUserUseCase {
  final AuthRepository _authRepository;

  SocialUserUseCase(this._authRepository);

  Future<void> signInWithGoogle() async {
    return await _authRepository.signInWithGoogle();
  }

  Future<void> logout() async {
    return await _authRepository.logout();
  }
}
