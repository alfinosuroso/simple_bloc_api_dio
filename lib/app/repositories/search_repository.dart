import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_bloc_api_dio/app/model/user.dart';
import 'package:simple_bloc_api_dio/app/repositories/base_search_repository.dart';
import 'package:simple_bloc_api_dio/app/services/api.dart';

class SearchRepository extends BaseSearchRepository {
  @override
  Future<List<UserModel>> getSearchUser(String name) async {
    try {
      final res = await Api().dio.get('?name=$name');
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
}