import 'package:http/http.dart';

import '../models/user.dart';
import '../app/app.locator.dart';
import '../services/api_service.dart';

abstract class UsersRepo {
  //* Public Properties
  User? loggedInUser;

  //* Public Methods
  Future<User> getUserAsync(int id);
  Future updateUserAsync(User user);
  Future<List<String>> getUserClasses(int id);
}

class UsersRepoImpl extends UsersRepo {
  final ApiService _apiService = locator<ApiService>();

  @override
  Future<User> getUserAsync(int id) async {
    Response response = await _apiService.getAsync("/users/profile/get?id=$id");
    return userFromJson(response.body, id);
  }

  @override
  Future updateUserAsync(User user) async {
    int id = user.id;
    await _apiService.postAsync(
        "/users/profile/update?id=$id", userToJson(user));
  }

  @override
  Future<List<String>> getUserClasses(int id) async {
    // TODO: implement getUserClasses
    throw UnimplementedError();
  }
}
