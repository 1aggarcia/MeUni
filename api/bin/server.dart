import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'controllers/event_controller.dart';
import 'controllers/user_controller.dart';
import 'locator.dart';

void main(List<String> args) async {
  setupLocator();

  // Configure routes.
  var router = Router();
  router = EventController().setUpRoutes(router, '/events');
  router = UserController().setUpRoutes(router, '/users');

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
