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
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  final refreshCtrl = RefreshController();
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
    PostListModel newModel = PostListModel.fromMap(response["response"]);

    if (page > 0 && state != null) {
      newModel.posts = [...state!.posts, ...newModel.posts];
      refreshCtrl.loadComplete();
    } else {
      refreshCtrl.refreshCompleted();
    }

    state = newModel;
    Logger().d(state);
  }

  Future<void> nextList() async {
    if (state == null || state!.isLast) {
      refreshCtrl.loadNoData();
      return;
    }
    await init(page: state!.pageNumber + 1);
  }
}

// 3. 창고관리자
final postListProvider =
    NotifierProvider<PostListVM, PostListModel?>(() => PostListVM());
