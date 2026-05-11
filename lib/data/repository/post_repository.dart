import 'package:dio/dio.dart';
import 'package:flutter_blog/_core/utils/my_http.dart';
import 'package:logger/logger.dart';

class PostRepository {
  static final PostRepository instance = PostRepository._single();

  // factory 문법 공부하기
  PostRepository._single();

  Future<Map<String, dynamic>> getPosts({int page = 0}) async {
    final response = await dio.get("/api/post?page=$page");

    //Logger().d(response.data);
    return response.data;
  }
}
