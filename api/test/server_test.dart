import 'dart:io';

import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  final port = '8080';
  final host = 'http://localhost:$port';
  late Process p;

  setUp(() async {
    p = await Process.start(
      'dart',
      ['run', 'bin/server.dart'],
      environment: {'PORT': port},
    );
    // Wait for server to start and print to stdout.
    await p.stdout.first;
  });

  tearDown(() => p.kill());

  userRouteTests(host);
}

void userRouteTests(String host) {
  test('GET user profile', () async {
    final response = await get(
      Uri.parse('$host/users/profile/get?id=1'),
    );
    expect(response.statusCode, 200);
    expect(
        response.body,
        '{"id":1,'
        '"firstName":"Fei",'
        '"lastName":"Huang",'
        '"year":4,'
        '"pronouns":"He/Him",'
        '"admin":true}');
  });
}
