import 'dart:convert';
import 'dart:math';

import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

import 'controller.dart';
import '../models/user.dart';
import 'mock_users.dart';

class UserController extends Controller {
  //* Private Properties
  final List<User> _users = MockUsersRepo().getMockUsers();

  //* Overriden Methods
  @override
  Router setUpRoutes(Router router, String endpoint) {
    String getEndpoint = "$endpoint/profile/get";
    return router
      ..get(getEndpoint, getUsersHandler);
  }

  //* Public API Methods

  // GET /
  Response getUsersHandler(Request request) {
    Map<String, dynamic> params = request.url.queryParameters;
    print(_users);
    
    try {
      int userId = int.parse(params['id']);
      dynamic user = findUser(userId);
      if (user is User) {
        return Response.ok(userToJson(user));
      } else {
        return Response(400);
      }
    } catch (e) {
      print("Failed to get user: $e");
      return Response(400);
    }
  }

  /// Return the user with given userId, if it exists
  /// @param userId of user
  /// @returns user if found, false otherwise
  dynamic findUser(int userId) {
    print(userId);
    int i = 0;
    User u = _users[i];
    // _users will be exausted or desired user found
    while (i < _users.length && u.id != userId) {
      u = _users[i];
      i++;
    }

    if (u.id == userId) {
      return u;
    } else {
      return false;
    }
  }
}