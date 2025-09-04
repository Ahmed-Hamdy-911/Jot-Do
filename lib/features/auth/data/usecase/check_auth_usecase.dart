import '../domain/auth_repository.dart';

class CheckAuthUseCase {
  final AuthRepository authRepository;

  CheckAuthUseCase(this.authRepository);

  Future<bool> call() async {
    return await authRepository.checkUserStatus();
  }

  Future<void> logout() async {
    return await authRepository.logout();
  }
}
