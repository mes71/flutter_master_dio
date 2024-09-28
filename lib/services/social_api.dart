import 'package:dio/dio.dart';
import 'package:flutter_master_dio/models/social/post.dart';
import 'package:flutter_master_dio/models/social/user.dart';
import 'package:flutter_master_dio/utils/custom_exception.dart';

class SocialApi {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com",
      contentType: 'application/json; charset=UTF-8',
      responseType: ResponseType.json));

  Future<List<User>> getAllUser() async {
    final response = await _dio.get("/users");

    List<User> res =
        List.from(response.data).map((e) => User.fromJson(e)).toList();
    return res;
  }

  Future<List<Post>> getPostsByUserId(int id) async {
    final response = await _dio.get("/users/$id/posts");

    List<Post> res =
        List.from(response.data).map((e) => Post.fromJson(e)).toList();
    return res;
  }

  Future<Post> createPostNew({required Post post}) async {
    final response = await _dio.post("/posts", data: post.toJson());
    print("Post created: ${response.data}");
    return Post.fromJson(response.data);
  }

  Future<Post> updatePost({required Post post}) async {
    final response = await _dio.put("/posts/${post.id}", data: post.toJson());
    print("Post updated : ${response.data}");
    return Post.fromJson(response.data);
  }

  Future<void> deletePost({required int id}) async {
    try {
      final response = await _dio.delete("/posts/$id/fake");
      print("Post deleted : ${response.data}");
    } on DioException catch (e) {
      var exception = CustomException.fromDio(e).toString();
      throw Exception(exception.toString());
    }
  }
}
