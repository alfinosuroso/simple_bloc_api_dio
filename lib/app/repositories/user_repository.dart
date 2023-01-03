import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_bloc_api_dio/app/model/user.dart';
import 'package:simple_bloc_api_dio/app/repositories/base_user_repository.dart';
import 'package:simple_bloc_api_dio/app/services/api.dart';

class UserRepository extends BaseUserRepository {
  @override
  Future<List<UserModel>> getAllUser() async {
    try {
      final res = await Api().dio.get('');
      debugPrint('Status code: ${res.statusCode}');
      debugPrint('Data: ${res.data}');

      if (res.statusCode == 200) {
        return (res.data as List).map((e) => UserModel.fromJson(e)).toList();
      } else {
        throw "Error";
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        debugPrint('Exception occured: $error stackTrace: $stacktrace');
      }
      throw 'Unauthorized';
    }
  }

  @override
  Future<UserModel> getUserById(String id) async {
    try {
      final res = await Api().dio.get('/$id');
      debugPrint('Status code: ${res.statusCode}');
      debugPrint('Data: ${res.data}');

      final model = UserModel.fromJson(res.data);

      if (res.statusCode == 200) {
        return model;
      } else {
        throw "Error";
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        debugPrint('Exception occured: $error stackTrace: $stacktrace');
      }
      throw 'Unauthorized';
    }
  }

  @override
  Future<void> deleteUser(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> postUser() {
    // TODO: implement postUser
    throw UnimplementedError();
  }

  // @override
  // Future<void> updateUser(int id, [String name, email]) {
  //   // TODO: implement updateUser
  //   throw UnimplementedError();
  // }
}
