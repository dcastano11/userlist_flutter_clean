import 'package:userlist_flutter_clean/data/models/post_model.dart';

class PostEntity{
  final int id;
  final int userId;
  final String title;
  final String body;
  
  PostEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory PostEntity.fromModel(PostModel model) {
    return PostEntity(
      id: model.id,
      userId: model.userId,
      title: model.title,
      body: model.body,
    );
  }
}
