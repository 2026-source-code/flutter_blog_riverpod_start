import 'package:flutter_blog/_core/utils/my_http.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';

void main() async {
  PostRepository repo = PostRepository.instance;
  dio.options.headers["Authorization"] = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpbWdVcmwiOiIvaW1hZ2VzLzEucG5nIiwic3ViIjoibWV0YWNvZGluZyIsImlkIjoxLCJleHAiOjE3Nzg2MzM0ODIsInVzZXJuYW1lIjoic3NhciJ9.yConZDFeNwQBVqHIyci7e5jJ8-vkxglYv8uw4WPpHWlVPrklbesK2L42kSYQYSCXcUiIXFcwEOQIBLzlaaw-ZA";
  await repo.getPosts(page: 0);
}
