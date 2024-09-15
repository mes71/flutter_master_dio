import 'package:dio/dio.dart';
import 'package:flutter_master_dio/models/social/user.dart';

class SocialApi {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"));

  Future<List<User>> getAllUser() async {
    final response = await _dio.get("/users");

    List<User> res =
        List.from(response.data).map((e) => User.fromJson(e)).toList();
    return res;
  }
}
