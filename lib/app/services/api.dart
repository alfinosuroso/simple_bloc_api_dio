import 'package:dio/dio.dart';

class Api {
  String token =
      '530cc23c0b036ad0a18d9357dc40c8698775059c7cc08dc1b0d84d32d1579404';

  late Map<String, dynamic> headers = {
    "Accept": "application/json",
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  late Dio dio = Dio(BaseOptions(
      baseUrl: 'https://gorest.co.in/public/v2/users',
      receiveTimeout: 10000,
      connectTimeout: 10000,
      headers: headers));
}
