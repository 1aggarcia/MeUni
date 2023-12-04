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
      ..post('$endpoint/profile/create', createUserHandler);
      // Unused method
      //..post('$endpoint/profile/update', updateUserHandler);
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

  // Unused method
  // Future<Response> updateUserHandler(Request request) async {
  //   return createUserHandler(request);
  // }
}
