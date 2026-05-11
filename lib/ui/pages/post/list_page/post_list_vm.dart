// 1. 창고데이터
import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/move.dart';
import 'package:flutter_blog/_core/utils/my_device.dart';
import 'package:flutter_blog/_core/utils/my_http.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';
import 'package:flutter_blog/data/repository/user_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/web.dart';

// 1. 창고 데이터 state 타입
class PostListModel {
  bool isFirst;
  bool isLast;
  int pageNumber;
  int size;
  int totalPage;

  List<Post> posts;

  PostListModel.fromMap(Map<String, dynamic> m)
      : isFirst = m["isFirst"],
        isLast = m["isLast"],
        pageNumber = m["pageNumber"],
        size = m["size"],
        totalPage = m["totalPage"],
        posts = (m["posts"] as List).map((e) => Post.fromMap(e)).toList();
}

// 2. 창고
class PostListVM extends Notifier<PostListModel?> {
  PostRepository postRepository = PostRepository.instance;
  final mContext = navigatorKey.currentContext!;

  // 최초 창고 동기화
  @override
  PostListModel? build() {
    init();
    return null;
  }

  Future<void> init({int page = 0}) async {
    Map<String, dynamic> response = await postRepository.getPosts(page: page);
    state = PostListModel.fromMap(response["response"]);
    Logger().d(state);
  }
}

// 3. 창고관리자
final postListProvider =
    NotifierProvider<PostListVM, PostListModel?>(() => PostListVM());
