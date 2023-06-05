import 'package:flutter/material.dart';
import 'package:userlist_flutter_clean/domain/entities/post_entity.dart';

class PostCard extends StatelessWidget {
  final PostEntity post;
  const PostCard(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(post.title),
              Text(post.body),
            ],
          ),
        ),
      ),
    );
  }
}
