import 'package:http/http.dart';

import '../models/user.dart';
import '../app/app.locator.dart';
import '../services/api_service.dart';

abstract class UsersRepo {
  //* Public Properties
  User? loggedInUser;

  //* Public Methods
  Future<User> getUserAsync(String id);
  Future<List<String>> getUserClasses(String id);

  Future updateUserAsync(User user);
}

class UsersRepoImpl extends UsersRepo {
  final ApiService _apiService = locator<ApiService>();

  @override
  Future<User> getUserAsync(String id) async {
    Response response = await _apiService.getAsync(
      Endpoints.getUser,
      params: {"id": id},
    );
    return userFromJson(response.body);
  }

  @override
  Future<List<String>> getUserClasses(String id) async {
    // TODO: implement getUserClasses
    throw UnimplementedError();
  }

  @override
  Future updateUserAsync(User user) async {
    await _apiService.postAsync(
      Endpoints.updateUser,
      params: {"id": user.id},
      body: userToJson(user),
    );
  }
}
