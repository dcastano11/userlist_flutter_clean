import 'package:userlist_flutter_clean/constants.dart';
import 'package:userlist_flutter_clean/data/models/user_model.dart';
import 'package:hive/hive.dart';


abstract class UserLocalDataSource {
  Future<List<User>> getUsersFromLocal();
  Future<void> saveUsersToLocal(List<User> users);
}

class UserLocalDataSourceImpl extends UserLocalDataSource {

  @override
  Future<void> saveUsersToLocal(List<User> users) async {
    final box = await Hive.openBox(Constants.kUserKey);
    for (var user in users) {

      await box.put(user.id, user);

    }
   
    
  }

  @override
  Future<List<User>> getUsersFromLocal() async {
    final box = await Hive.openBox(Constants.kUserKey);
    
    return box.values.toList().cast<User>();
  }
}

