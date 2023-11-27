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
    return router..get('$endpoint/profile/get', getUserHandler);
  }

  //* Public API Methods

  // GET /
  // Return a single user
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
}
