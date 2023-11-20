import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

import '../locator.dart';
import '../repository/users_repo.dart';
import 'controller.dart';
import '../models/user.dart';

class UserController extends Controller {
  //* Private Properties
  final _usersRepo = locator<UsersRepo>();

  //* Overriden Methods
  @override
  Router setUpRoutes(Router router, String endpoint) {
     return router
    //   ..post('$endpoint/profile/create', createUserHandler)
    //   ..post('$endpoint/profile/update', updateUserHandler)
      ..get('$endpoint/profile/get', getUserHandler);

      // ..get('$endpoint/friends/get', getUserFriendsHanlder)
      // ..post('$endpoint/friends/add', addUserFriendsHandler)
      // ..post('$endpoint/friends/remove', removeUserFriendsHandler);
  }

  //* Public API Methods

  // GET /
  Future<Response> getUserHandler(Request request) async {
    Map<String, dynamic> params = request.url.queryParameters;

    try {
      User? user = await _usersRepo.getUserAsync(params['id']);

      if (user != null) {
        return Response.ok(userToJson(user));
      } else {
        return Response(400);
      }
    } catch (e) {
      print("Failed to get user: $e");
      return Response(400);
    }
  }

  // Future<Response> getUserFriendsHandler(Request request) async {
  //   Map<String, dynamic> params = request.url.queryParameters;

  //   try {
  //     User? user = await _usersRepo.getUserAsync(params['id']);

  //     if (user != null) {
  //       return Response.ok(userToJson(user));
  //     } else {
  //       return Response(400);
  //     }
  //   } catch (e) {
  //     print("Failed to get user: $e");
  //     return Response(400);
  //   }
  // }

  // // POST /

  // // Sends a piece of user information and store it
  // Future<Response> createUsersHandler(Request request) async {
  //   String body = await request.readAsString();

  //   try {
  //     User? user = userFromJson(body);
  //     if (user != null) {
  //       int newId = await _usersRepo.createUserAsync(user);
  //       return Response.ok("$newId");
  //     } else {
  //       return Repsonse(400);
  //     }
  //   } catch (e) {
  //     return Response(400);
  //   }
  // }

  // Future<Response> updateUsersHandler(Request request) async {
  //   String body = await request.readAsString();

  // }

  // Future<Response> addUserFriendsHandler(Request request) async {
  //   String body = await request.readAsString();
  // }

  // Future<Response> removeUserFriendsHandler(Request request) async {
  //   String body = await request.readAsString();
  //}

}
