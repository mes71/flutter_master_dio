import 'package:dio/dio.dart';
import 'package:flutter_master_dio/models/social/post.dart';
import 'package:flutter_master_dio/models/social/user.dart';
import 'package:flutter_master_dio/utils/custom_exception.dart';

class SocialApi {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com",
      contentType: 'application/json; charset=UTF-8',
      responseType: ResponseType.json));

  Future<T> _getRequest<T>(
      String path, T Function(dynamic data) fromJson) async {
    try {
      final response = await _dio.get(path);
      return fromJson(response.data);
    } on DioException catch (e) {
      throw CustomException.fromDio(e);
    }
  }

  Future<T> _postRequest<T>(
      String path, T Function(dynamic data) fromJson) async {
    try {
      final response = await _dio.get(path);
      return fromJson(response.data);
    } on DioException catch (e) {
      throw CustomException.fromDio(e);
    }
  }

  Future<T> _putRequest<T>(
      String path, T Function(dynamic data) fromJson) async {
    try {
      final response = await _dio.get(path);
      return fromJson(response.data);
    } on DioException catch (e) {
      throw CustomException.fromDio(e);
    }
  }

  Future<T> _deleteRequest<T>(
      String path, T Function(dynamic data) fromJson) async {
    try {
      final response = await _dio.get(path);
      return fromJson(response.data);
    } on DioException catch (e) {
      throw CustomException.fromDio(e);
    }
  }

  Future<List<User>> getAllUser() async {
    return await _getRequest("/users", (data) {
      List<User> res = List.from(data).map((e) => User.fromJson(e)).toList();
      return res;
    });
  }

  Future<List<Post>> getPostsByUserId(int id) async {
    return await _getRequest("/users/$id/posts",
        (data) => List.from(data).map((e) => Post.fromJson(e)).toList());
  }

  Future<Post> createPostNew({required Post post}) async {
    return await _postRequest("/posts", (data) => Post.fromJson(data));
  }

  Future<Post> updatePost({required Post post}) async {
    return await _putRequest(
        "/posts/${post.id}", (data) => Post.fromJson(data));
  }

  Future<void> deletePost({required int id}) async {
    return await _deleteRequest(
        "/posts/$id/fake", (data) => Post.fromJson(data));
  }
}
