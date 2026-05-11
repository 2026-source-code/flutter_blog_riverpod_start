import 'package:flutter_blog/data/repository/user_repository.dart';

void main() async {
  UserRepository repo = UserRepository.instance;
  await repo.login("ssar", "1234");
}
