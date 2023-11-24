import 'dart:io' as io;

import 'package:dotenv/dotenv.dart';
import 'package:firebase_dart/core.dart';
import 'package:firebase_dart/database.dart';
import 'package:firebase_dart/implementation/pure_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'controllers/event_controller.dart';
import 'controllers/study_group_controller.dart';
import 'controllers/user_controller.dart';
import 'locator.dart';

void main(List<String> args) async {
  FirebaseDart.setup();

  var env = DotEnv(includePlatformEnvironment: true)..load();
  final options = FirebaseOptions(
    appId: env['APP_ID'] as String,
    apiKey: env['API_KEY'] as String,
    projectId: env['PROJECT_ID'] as String,
    messagingSenderId: env['SENDER_ID'] as String,
    authDomain: env['AUTH_DOMAIN'] as String,
    databaseURL: env['DATABASE_URL'] as String,
  );
  final app = await Firebase.initializeApp(options: options);
  final DatabaseReference database = FirebaseDatabase(app: app).reference();

  setupLocator(database);

  // Configure routes.
  var router = Router();
  router = UserController().setUpRoutes(router, '/users');
  router = EventController().setUpRoutes(router, '/events');
  router = StudyGroupController().setUpRoutes(router, '/study_groups');

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = io.InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(io.Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
