import 'package:simple_bloc_api_dio/app/model/user.dart';

abstract class BaseUserRepository {
  Future<List<UserModel>> getAllUser();
  Future<UserModel> getUserById(String id);
  Future<void> postUser();
  // Future<void> updateUser(int id, [String name, email]);
  Future<void> deleteUser(int id);
}
