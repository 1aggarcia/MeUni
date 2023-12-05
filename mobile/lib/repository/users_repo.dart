import 'dart:convert';

import 'package:http/http.dart';

import '../app/app.locator.dart';
import '../models/user.dart';
import '../services/api_service.dart';

abstract class UsersRepo {
  Future<User?> addUserAsync({
    required String id,
    required String firstName,
    required String lastName,
    required int year,
    required String pronouns,
  });

  Future<User?> getUserAsync(String id);

  Future<bool> addUserClassAsync({
    required String id,
    required String className,
  });
  Future<List<String>> getUserClassesAsync(String id);

  Future<void> updateUserAsync(User user);
}

class UsersRepoImpl extends UsersRepo {
  //* Private Properties
  final ApiService _apiService = locator<ApiService>();

  //* Overridden Methods
  @override
  Future<User?> addUserAsync({
    required String id,
    required String firstName,
    required String lastName,
    required int year,
    required String pronouns,
  }) async {
    User user = User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      year: year,
      pronouns: pronouns,
      admin: false,
    );

    Response response = await _apiService.postAsync(
      Endpoints.createUser,
      body: _userToJson(user),
    );

    String apiId = response.body;
    return apiId == user.id ? user : null;
  }

  @override
  Future<User?> getUserAsync(String id) async {
    Response response = await _apiService.getAsync(
      Endpoints.getUser,
      params: {'id': id},
    );

    return _userFromJson(response.body);
  }

  @override
  Future<bool> addUserClassAsync({
    required String id,
    required String className,
  }) async {
    Response response = await _apiService.postAsync(
      Endpoints.createUserClass,
      body: jsonEncode({
        'userId': id,
        'course': className,
      }),
    );

    return responseOk(response);
  }

  @override
  Future<List<String>> getUserClassesAsync(String id) async {
    Response response = await _apiService.getAsync(
      Endpoints.getUserClasses,
      params: {'id': id},
    );

    return _classesFromJson(response.body);
  }

  @override
  Future<void> updateUserAsync(User user) async {
    await _apiService.postAsync(
      Endpoints.updateUser,
      params: {'id': user.id},
      body: _userToJson(user),
    );
  }

  //* Private Methods
  List<String> _classesFromJson(String json) =>
      List<String>.from(jsonDecode(json));

  User _userFromJson(String json) => User.fromJson(jsonDecode(json));

  String _userToJson(User data) => jsonEncode(data.toJson());
}
