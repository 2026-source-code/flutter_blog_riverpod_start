import 'package:intl/intl.dart';

class User {
  final int id;
  final String username;
  final String email;
  final String imgUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.imgUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  // 응답 받은 데이터를 json 처럼 생긴 Map => Dart 오브젝트로 변환하는 함수
  User.fromMap(Map<String, dynamic> m)
      : id = m["id"],
        username = m["username"] ?? "",
        email = m["email"] ?? "",
        imgUrl = m["imgUrl"] ?? "",
        createdAt = m["createdAt"] != null ? DateFormat("yyyy-mm-dd").parse(m["createdAt"]) : null,
        updatedAt = m["updatedAt"] != null ? DateFormat("yyyy-mm-dd").parse(m["updatedAt"]) : null;
}