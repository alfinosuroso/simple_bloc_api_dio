import 'package:simple_bloc_api_dio/app/model/user.dart';

abstract class BaseUserRepository {
  Future<List<UserModel>> getAllUser();
  Future<UserModel> getUserById(String id);
  Future<UserModel> postUser(String name, String gender, String email, String status);
  Future<UserModel> updateUser(String id, String name, String email, String status);
  Future<UserModel> deleteUser(String id);
}
