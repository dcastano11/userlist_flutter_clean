import 'package:hive/hive.dart';
part 'user_model.g.dart';

class UserList{

  List<User>? userList;
  
  UserList.fromJson(List<Map<String, dynamic>> users){
    userList = users.map((e) => User.fromJson(e)).toList();
  }
}

@HiveType(typeId: 0)
class User extends HiveObject{

  @HiveField(0)
  final int id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String email;
  
  @HiveField(3)
  final String phone;
  
  User({required this.id, required this.name, required this.email, required this.phone});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'], 
        name = json['name'],
        email = json['email'],
        phone = json['phone'];
 
   Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'email':email,
      'phone':phone,
     
    };
  }
} 