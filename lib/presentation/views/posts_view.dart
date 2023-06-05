import 'package:flutter/material.dart';
import 'package:userlist_flutter_clean/constants.dart';
import 'package:userlist_flutter_clean/domain/entities/post_entity.dart';
import 'package:userlist_flutter_clean/domain/entities/user_entity.dart';
import 'package:userlist_flutter_clean/presentation/viewModels/posts_view_model.dart';
import 'package:userlist_flutter_clean/presentation/views/components/post_card.dart';

class PostsView extends StatelessWidget {
  final UserEntity user;
  final PostsViewModel viewModel;

  PostsView({super.key, required this.user, required this.viewModel}) {
    viewModel.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            userInfo(),
            divider(),
            Expanded(
              child: postsList(),
            ),
          ],
        ),
      ),
    );
  }

  Padding divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Divider(
        thickness: 1.5,
      ),
    );
  }

  StreamBuilder<List<PostEntity>> postsList() {
    return StreamBuilder<List<PostEntity>>(
      stream: viewModel.postsStream.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final posts = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: posts.map<Widget>((post) {
                return PostCard(post);
              }).toList(),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Center(
            child: Text("NO POSTS FOUND FOR THIS USER"),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("ERROR OCCURRED"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Column userInfo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 16,
        ),
        userNameTitle(),
        const SizedBox(
          height: 8,
        ),
        userEmail(),
        const SizedBox(
          height: 4,
        ),
        userPhone(),
        const SizedBox(
          height: 4,
        ),
      ],
    );
  }

  Text userPhone() => Text(user.phone, textAlign: TextAlign.center);

  Text userEmail() => Text(user.email, textAlign: TextAlign.center);

  Text userNameTitle() {
    return Text(
      user.name,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        color: Constants.mainGreen,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

