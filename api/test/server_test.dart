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

  test('Root', () async {
    final response = await get(Uri.parse('$host/'));
    expect(response.statusCode, 200);
    expect(response.body, 'Hello, World!\n');
  });

  test('POST articles', () async {
    final response = await post(
      Uri.parse('$host/articles'),
      body: '{"title":"My super article","content":"My super content"}',
    );
    expect(response.statusCode, 200);
    expect(response.body,
        '{"title":"My super article","content":"My super content"}');
  });

  test('POST articles with empty string', () async {
    final response = await post(
      Uri.parse('$host/articles'),
      body: '',
    );
    expect(response.statusCode, 400);
  });

  test('GET articles', () async {
    await post(
      Uri.parse('$host/articles'),
      body: '{"title":"My super article","content":"My super content"}',
    );
    final response = await get(
      Uri.parse('$host/articles'),
    );
    expect(response.statusCode, 200);
    expect(response.body,
        '[{"title":"My super article","content":"My super content"}]');
  });

  test('POST events', () async {
    final response = await post(
      Uri.parse('$host/events/create'),
      body: '{"title":"Pizza",'
        '"desc":"need ppl to chip in for pizza",'
        '"location":"The crib",'
        '"max":4,'
        '"startTime":"2023-11-04T03:04:15.537017Z",'
        '"endTime":"2023-11-04T03:24:15.537017Z",'
        '"hostId":1,'
        '"attendees":[1,2]}',
    );
    expect(response.statusCode, 200);
    expect(response.body,
        '{"id":0,'
        '"title":"Pizza",'
        '"desc":"need ppl to chip in for pizza",'
        '"location":"The crib",'
        '"max":4,'
        '"startTime":"2023-11-04T03:04:15.537017Z",'
        '"endTime":"2023-11-04T03:24:15.537017Z",'
        '"hostId":1,'
        '"attendees":[1,2]}');
  });

  test('POST events with no body', () async {
    final response = await post(
      Uri.parse('$host/events/create'),
      body: '',
    );
    expect(response.statusCode, 400);
  });

  test('POST events with wrong types', () async {
    final response = await post(
      Uri.parse('$host/events/create'),
      body: '{"title":0,'
        '"desc":"need ppl to chip in for pizza",'
        '"location":"The crib",'
        '"max":"",'
        '"startTime":"12/25/23",'
        '"endTime":"2023-11-04T03:24:15.537017Z",'
        '"hostId":1,'
        '"attendees":25}',
    );
    expect(response.statusCode, 400);
  });

  test('GET events', () async {
    await post(
      Uri.parse('$host/events/create'),
      body: '{"title":"Tennis",'
        '"desc":"At the IMA tennis court! Hang out with me!",'
        '"location":"IMA tennis court",'
        '"max":3,'
        '"startTime":"2024-01-04T15:14:15.537017Z",'
        '"endTime":"2023-11-04T16:14:15.567017Z",'
        '"hostId":2,'
        '"attendees":[3]}',
    );
    final response = await get(
      Uri.parse('$host/events/get'),
    );
    expect(response.statusCode, 200);
    expect(response.body,
        '[{"id":0,'
        '"title":"Tennis",'
        '"desc":"At the IMA tennis court! Hang out with me!",'
        '"location":"IMA tennis court",'
        '"max":3,'
        '"startTime":"2024-01-04T15:14:15.537017Z",'
        '"endTime":"2023-11-04T16:14:15.567017Z",'
        '"hostId":2,'
        '"attendees":[3]}]');
  });

}