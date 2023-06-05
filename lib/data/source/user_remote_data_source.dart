import 'dart:convert';
import 'package:userlist_flutter_clean/constants.dart';
import 'package:userlist_flutter_clean/data/models/post_model.dart';
import 'package:userlist_flutter_clean/data/models/user_model.dart';
import 'package:http/http.dart';

abstract class UserRemoteDataSource {
  Future<List<User>> fetchUsers();
  Future<List<PostModel>> fetchPostsByUserId(int userId);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<List<User>> fetchUsers() async {
    var usersUrl =
        Uri(scheme: 'https', host: Constants.baseUrl, path: "users");
    var response = get(usersUrl).then<List<User>>((response) {
      var decodedResponse = jsonDecode(response.body);
      List<User> userList =
          decodedResponse.map<User>((e) => User.fromJson(e)).toList();
      return userList;
    });
    return response;
  }

  @override
  Future<List<PostModel>> fetchPostsByUserId(int userId) async {
    try {
      var requestUri =
          Uri.parse('https://${Constants.baseUrl}/posts?userId=$userId');
      final response = get(requestUri).then((response) {
        if (response.statusCode == 200) {
          final List<dynamic> jsonPosts = json.decode(response.body);
          // Map the JSON data to PostModel objects
          final posts =
              jsonPosts.map((json) => PostModel.fromJson(json)).toList();
          return posts;
        } else {
          throw Exception(
              'Failed to fetch posts. Status code: ${response.statusCode}');
        }
      });

      return response;
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }
}
