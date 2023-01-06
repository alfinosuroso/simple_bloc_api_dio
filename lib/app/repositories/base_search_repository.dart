import 'package:simple_bloc_api_dio/app/model/user.dart';

abstract class BaseSearchRepository {
  Future<List<UserModel>> getSearchUser(String name);
}