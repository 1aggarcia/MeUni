import 'dart:io';
import 'dart:convert';

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
    p.stdout.transform(utf8.decoder).listen((data) {
      print(data);
    });
    await p.exitCode;
    //await p.stdout.first;
  });

  tearDown(() => p.kill());

  test('Test Server', () async {
    final response = await get(
      Uri.parse('$host/events/get'),
    );
    expect(response.statusCode, 200);
    expect(response.body.isNotEmpty, true);
  });
}
