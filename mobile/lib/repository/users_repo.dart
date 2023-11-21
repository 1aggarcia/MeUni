import 'dart:convert';

import 'package:http/http.dart';

import '../app/app.locator.dart';
import '../models/user.dart';
import '../services/api_service.dart';

abstract class UsersRepo {
  Future<User> addUserAsync({
    required String id,
    required String firstName,
    required String lastName,
    required int year,
    required String pronouns,
  });

  Future<User?> getUserAsync(String id);

  Future<List<String>> getUserClasses(String id);

  Future<void> updateUserAsync(User user);
}

class UsersRepoImpl extends UsersRepo {
  //* Private Properties
  final ApiService _apiService = locator<ApiService>();

  //* Overridden Methods
  @override
  Future<User?> getUserAsync(String id) async {
    Response response = await _apiService.getAsync(
      Endpoints.getUser,
      params: {'id': id},
    );
    return _userFromJson(response.body);
  }

  @override
  Future<List<String>> getUserClasses(String id) async {
    // TODO: implement getUserClasses
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserAsync(User user) async {
    await _apiService.postAsync(
      Endpoints.updateUser,
      params: {'id': user.id},
      body: _userToJson(user),
    );
  }

  @override
  Future<User> addUserAsync(
      {required String id,
      required String firstName,
      required String lastName,
      required int year,
      required String pronouns}) {
    // TODO: implement addUserAsync
    throw UnimplementedError();
  }

  //* Private Methods
  User _userFromJson(String str) => User.fromJson(json.decode(str));

  String _userToJson(User data) => json.encode(data.toJson());
}
