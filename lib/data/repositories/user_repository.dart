import 'package:userlist_flutter_clean/data/source/user_local_data_source.dart';
import 'package:userlist_flutter_clean/data/source/user_remote_data_source.dart';
import 'package:userlist_flutter_clean/domain/entities/post_entity.dart';
import 'package:userlist_flutter_clean/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsers();
  Future<List<PostEntity>> getPostsByUserId(int userId);
}

class UserRepositoryImpl extends UserRepository {
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<List<UserEntity>> getUsers() {
    try {
      return localDataSource.getUsersFromLocal().then((localUsers) {
        if (localUsers.isNotEmpty) {
          return localUsers.map((user) => UserEntity.fromModel(user)).toList();
        } else {
          return remoteDataSource
              .fetchUsers()
              .then<List<UserEntity>>((remoteUsers) async {
            await localDataSource.saveUsersToLocal(remoteUsers);
            return remoteUsers
                .map((user) => UserEntity.fromModel(user))
                .toList();
          });
        }
      });
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  @override
  Future<List<PostEntity>> getPostsByUserId(int userId) async {
    try {
      // Fetch posts from the remote data source
      final remotePosts = await remoteDataSource.fetchPostsByUserId(userId);
      // Save the fetched posts locally if needed

      return remotePosts.map((post) => PostEntity.fromModel(post)).toList();
    } catch (e) {
      // Handle errors and exceptions accordingly
      throw Exception('Failed to fetch posts: $e');
    }
  }
}
