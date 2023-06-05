import 'package:userlist_flutter_clean/data/models/user_model.dart';

class UserEntity{
  final int id;
  final String name;
  final String email;
  final String phone;

  UserEntity({required this.id, required this.name, required this.email, required this.phone});

  factory UserEntity.fromModel(User userModel) {
    return UserEntity(
      id: userModel.id,
      name: userModel.name,
      email: userModel.email,
      phone: userModel.phone,
    );
  }

  User toModel() {
    return User(
      id: id,
      name: name,
      email: email,
      phone: phone,
    );
  } 
}
