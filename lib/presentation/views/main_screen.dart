import 'package:flutter/material.dart';
import 'package:userlist_flutter_clean/data/repositories/user_repository.dart';
import 'package:userlist_flutter_clean/domain/entities/user_entity.dart';
import 'package:userlist_flutter_clean/presentation/viewModels/main_screen_view_model.dart';
import 'package:userlist_flutter_clean/presentation/views/components/user_list.dart';

class MainScreen extends StatelessWidget {
  final UserRepository userRepository;
  late final MainScreenViewModel viewModel;
  MainScreen({super.key, required this.userRepository}) {
    viewModel = MainScreenViewModel(userRepository: userRepository);
  }

  void dispose() {
    viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          searchField(),
          Expanded(
            child: userList(),
          ),
        ],
      ),
    );
  }

  StreamBuilder<List<UserEntity>?> userList() {
    return StreamBuilder<List<UserEntity>?>(
      stream: viewModel.usersStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return UserList(
            users: snapshot.data ?? [],
            dataRepository: userRepository,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: false,
      title: const Text(
        "Prueba de Ingreso",
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget searchField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: viewModel.search,
        decoration: const InputDecoration(
          labelText: "Buscar Usuario",
        ),
      ),
    );
  }
}
