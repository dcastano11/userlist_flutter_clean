import 'dart:async';

import 'package:userlist_flutter_clean/data/repositories/user_repository.dart';
import 'package:userlist_flutter_clean/domain/entities/post_entity.dart';

class PostsViewModel {
  final UserRepository repository;
  final int userId;
  final StreamController<List<PostEntity>> _postsStreamController =
      StreamController();
  StreamController<List<PostEntity>> get postsStream => _postsStreamController;

  PostsViewModel({required this.repository, required this.userId});

  Future<void> fetchPosts() async {
    try {
      final posts = await repository.getPostsByUserId(userId);
      _postsStreamController.add(posts);
    } catch (e) {
      _postsStreamController.addError(e);
    }
  }
}