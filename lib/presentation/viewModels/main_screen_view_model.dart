
import 'dart:async';
import 'package:userlist_flutter_clean/data/repositories/user_repository.dart';
import 'package:userlist_flutter_clean/domain/entities/user_entity.dart';

class MainScreenViewModel {
  
  final UserRepository userRepository;
  late List<UserEntity>? _users;
  Stream<List<UserEntity>?> get usersStream => _usersController.stream;
  final _usersController = StreamController<List<UserEntity>?>();

  MainScreenViewModel({required this.userRepository}) {
    _getUsers();
  }

  void _getUsers() {
    userRepository.getUsers().then((value) {
      _users = value;
      _usersController.add(_users);
    }).catchError((error) {
      _usersController.addError(error);
    });
  }

  void search(String keyword) {
    if (_users == null) return;

    if (keyword.isEmpty) {
      _usersController.add(_users!);
    } else {
      final filteredUsers = _users!
          .where((user) => user.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
      _usersController.add(filteredUsers);
    }
  }

  void dispose() {
    _usersController.close();
  }
}
