import 'package:flutter/material.dart';
import 'package:userlist_flutter_clean/constants.dart';
import 'package:userlist_flutter_clean/data/repositories/user_repository.dart';
import 'package:userlist_flutter_clean/domain/entities/user_entity.dart';
import 'package:userlist_flutter_clean/presentation/viewModels/posts_view_model.dart';
import 'package:userlist_flutter_clean/presentation/views/posts_view.dart';

class UserCell extends StatelessWidget {
  final UserEntity user;
  final UserRepository dataRepository;

  const UserCell({
    super.key,
    required this.dataRepository,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 8,
            ),
            nameRow(),
            phoneRow(),
            emailRow(),
            postsLinkRow(context)
          ],
        ),
      ),
    );
  }

  Padding nameRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        user.name,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Constants.mainGreen, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding postsLinkRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextButton(
                
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) {
                          var viewModel = PostsViewModel(repository: dataRepository, userId: user.id);
                          return PostsView(user: user, viewModel: viewModel,);})));
                },
                child: const Text("VER PUBLICACIONES")),
          )
        ],
      ),
    );
  }

  Padding emailRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const Icon(Icons.mail),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Text(user.email),
          )
        ],
      ),
    );
  }

  Padding phoneRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const Icon(Icons.phone),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Text(user.phone),
          )
        ],
      ),
    );
  }
}
