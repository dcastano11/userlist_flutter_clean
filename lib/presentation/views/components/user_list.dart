import 'package:flutter/material.dart';
import 'package:userlist_flutter_clean/constants.dart';
import 'package:userlist_flutter_clean/data/repositories/user_repository.dart';
import 'package:userlist_flutter_clean/domain/entities/user_entity.dart';
import 'package:userlist_flutter_clean/presentation/views/components/user_cell.dart';

class UserList extends StatelessWidget {
  const UserList({super.key, required this.users, required this.dataRepository});

  final List<UserEntity> users;
  final UserRepository dataRepository;

  @override
  Widget build(BuildContext context) {
    return users.isEmpty ? 
      emptyAdvice():
      userList();
  }

  Center emptyAdvice() => Center(child: Text("List is empty", style: TextStyle(color: Constants.mainGreen, fontSize: 30),),);

  SingleChildScrollView userList() {
    return SingleChildScrollView(
      child: Column(
        children: users.map((e) => UserCell(user: e, dataRepository: dataRepository)).toList()
    ),
  );
  }
}