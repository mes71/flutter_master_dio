import 'package:dio/dio.dart';

class SocialApi {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"));

  Future getAllUser() async {
    final response = await _dio.get("/users");
    print(response.data);
    return response.data;
  }
}
