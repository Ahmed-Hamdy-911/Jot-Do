import '../domain/auth_repository.dart';

class LoginUserUseCase {
  final AuthRepository _authRepository;

  LoginUserUseCase(this._authRepository);

  Future<void> call({
    required String email,
    required String password,
  }) async {
    return await _authRepository.login(email: email, password: password);
  }
}
