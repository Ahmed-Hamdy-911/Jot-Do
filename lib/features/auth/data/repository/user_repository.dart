import '../models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> getUserById(String id);
  Future<void> saveUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(String id);
}
