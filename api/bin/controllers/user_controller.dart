import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../locator.dart';
import '../models/user.dart';
import '../repository/users_repo.dart';
import 'controller.dart';

class UserController extends Controller {
  //* Private Properties
  final _usersRepo = locator<UsersRepo>();

  //* Overriden Methods
  @override
  Router setUpRoutes(Router router, String endpoint) {
    return router
      ..get('$endpoint/profile/get', getUserHandler)
      ..post('$endpoint/profile/create', createUserHandler)
      ..get('$endpoint/courses/get', getUserCoursesHandler)
      ..post('$endpoint/courses/add', addUserCoursesHandler)
      ..post('$endpoint/courses/remove', removeUserCoursesHandler);
  }

  //* Public API Methods

  // GET /
  // Return a single user
  Future<Response> getUserHandler(Request request) async {
    Map<String, dynamic> params = request.url.queryParameters;

    if (params.containsKey('id')) {
      try {
        User? user = await _usersRepo.getUserAsync(params['id']);
        if (user != null) {
          return Response.ok(userToJson(user));
        } else {
          return Response(404);
        }
      } catch (e) {
        return Response(400);
      }
    }
    return Response(400);
  }

  Future<Response> getUserCoursesHandler(Request request) async {
    Map<String, dynamic> params = request.url.queryParameters;

    if (params.containsKey('id')) {
      try {
        List<String> courses =
            await _usersRepo.getUserCoursesAsync(params['id']);
        return Response.ok(jsonEncode(courses));
      } catch (e) {
        return Response(400);
      }
    }
    return Response(400);
  }

  // POST /
  Future<Response> createUserHandler(Request request) async {
    String body = await request.readAsString();

    try {
      User? user = userFromJson(body);
      print('TEST 1');
      if (user != null) {
        String newId = await _usersRepo.addUserAsync(user);
        return Response.ok(newId);
      } else {
        throw Exception('Json body could not be converted into User');
      }
    } catch (e) {
      print('Failed to create user: $e');
      return Response(400);
    }
  }

  Future<Response> addUserCoursesHandler(Request request) async {
    String json = await request.readAsString();

    try {
      dynamic body = jsonDecode(json);
      String? userId = body['userId'];
      String? course = body['course'];
      if (userId != null && course != null) {
        bool success = await _usersRepo.addUserCoursesAsync(userId, course);
        return Response.ok(success.toString());
      } else {
        throw Exception('userId and courses are null');
      }
    } catch (e) {
      print('Failed to create user: $e');
      return Response(400);
    }
  }

  Future<Response> removeUserCoursesHandler(Request request) async {
    String json = await request.readAsString();

    try {
      dynamic body = jsonDecode(json);
      String? userId = body['userId'];
      String? course = body['course'];
      if (userId != null && course != null) {
        bool success = await _usersRepo.removeUserCoursesAsync(userId, course);
        return Response.ok(success.toString());
      } else {
        throw Exception('userId and courses are null');
      }
    } catch (e) {
      print('Failed to create user: $e');
      return Response(400);
    }
  }
}
