import 'package:dotenv/dotenv.dart';
import 'package:firebase_dart/core.dart';

var env = DotEnv(includePlatformEnvironment: true)..load();

class Secrets {
  static final options = FirebaseOptions(
    apiKey: env['API_KEY'] as String,
    appId: env['APP_ID'] as String,
    messagingSenderId: env['SENDER_ID'] as String,
    projectId: env['PROJECT_ID'] as String,
    authDomain: env['AUTH_DOMAIN'] as String,
    databaseURL: env['DATABASE_URL'] as String,
  );

  // static final String serviceAccount = env['SERVICE_ACCOUNT'] as String;
  // static final String serviceKey = env['SERVICE_KEY'] as String;
}