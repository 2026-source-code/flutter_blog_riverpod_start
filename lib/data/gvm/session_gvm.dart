// 1. 창고데이터
import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/move.dart';
import 'package:flutter_blog/_core/utils/my_device.dart';
import 'package:flutter_blog/_core/utils/my_http.dart';
import 'package:flutter_blog/data/repository/user_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_blog/ui/pages/post/list_page/post_list_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/web.dart';

class SessionUser {
  int? id;
  String? username;
  String? imgUrl;
  String? accessToken;
  bool isLogin;

  SessionUser(
      {this.id,
      this.username,
      this.imgUrl,
      this.accessToken,
      this.isLogin = false});
  SessionUser.fromMap(Map<String, dynamic> m)
      : id = m["id"],
        username = m["username"],
        imgUrl = m["imgUrl"],
        accessToken = m["accessToken"],
        isLogin = true;
}

// 2. 창고
class SessionGVM extends Notifier<SessionUser> {
  UserRepository userRepository = UserRepository.instance;
  final mContext = navigatorKey.currentContext!;

  @override
  SessionUser build() {
    return SessionUser();
  }

  Future<void> autoLogin() async {
    // 1. 디바이스 토큰이 있는걸 가져오기
    String? accessToken = await secureStorage.read(key: "accessToken");
    print("autoLogin : ${accessToken}");

    // 2. user_repository -> autoLogin
    if (accessToken != null) {
      final response = await userRepository.autoLogin(accessToken);
      print("response : ${response}");
      if (response["success"]) {
        print("자동 로그인 성공-----------------------");

        // 상태갱신
        state = SessionUser.fromMap(response["response"]);
        state.accessToken = accessToken;

        // dio 세팅
        dio.options.headers["Authorization"] = state.accessToken;

        // 화면이동 (비지니스 책임 위배!)
        Navigator.popAndPushNamed(mContext, Move.postListPage);
      }
    }
  }

  Future<void> login(String username, String password) async {
    final response = await userRepository.login(username, password);
    state = SessionUser.fromMap(response["response"]);

    // 1. 디바이스 저장
    secureStorage.write(key: "accessToken", value: state.accessToken);

    // 2. DIO 세팅
    dio.options.headers["Authorization"] = state.accessToken;

    Navigator.popAndPushNamed(mContext, Move.postListPage);
  }

  Future<void> logout() async {
    state = SessionUser();

    // 1. 디바이스 저장
    await secureStorage.delete(key: "accessToken");

    // 2. DIO 세팅
    dio.options.headers["Authorization"] = "";
  }
}

// 3. 창고관리자
final sessionProvider =
    NotifierProvider<SessionGVM, SessionUser>(() => SessionGVM());
