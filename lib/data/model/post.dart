import 'package:flutter_blog/data/model/user.dart';
import 'package:intl/intl.dart';

class Post {
  final int id;
  final String title;
  final String content;
  final User user;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? bookmarkCount;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.bookmarkCount
  });

  // 통신을 위해서 json 처럼 생긴 문자열 {"id":1} => Dart 오브젝트
  Post.fromMap(Map<String, dynamic> m)
      : id = m["id"],
        title = m["title"] ?? "",
        content = m["content"] ?? "",
        user = User.fromMap(m["user"]),
        createdAt = m["createdAt"] != null ? DateFormat("yyyy-mm-dd").parse(m["createdAt"]) : null,
        updatedAt = m["updatedAt"] != null ? DateFormat("yyyy-mm-dd").parse(m["updatedAt"]) : null,
        bookmarkCount = m["bookmarkCount"] ?? 0;
}