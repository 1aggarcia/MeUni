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

  articleRouteTests(host);
  eventRouteTests(host);
  userRouteTests(host);
}

void articleRouteTests(String host) {
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
}

void eventRouteTests(String host) {
  final String mockEvents = '{"id":-3,"title":"Pizza","desc":"need ppl to chip in for pizza","location":"The crib","max":4,"startTime":"2023-11-04T03:04:15.537017Z","endTime":"2023-11-04T03:24:15.537017Z","hostId":1,"attendees":[1,2]},{"id":-2,"title":"Event 1","desc":"This is a sample description for this event","location":"UW CSE2 G21","max":3,"startTime":"2023-11-04T02:24:25.537017Z","endTime":"2023-11-07T03:24:15.537017Z","hostId":2,"attendees":[1,2]},{"id":-1,"title":"Another event","desc":"This time i really need people","location":"[Redacted]","max":2,"startTime":"2023-11-05T03:04:15.537017Z","endTime":"2023-11-05T03:24:15.537017Z","hostId":1,"attendees":[1]}';

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

  test('GET events no params', () async {
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
        '[$mockEvents,'
        '{"id":0,'
        '"title":"Tennis",'
        '"desc":"At the IMA tennis court! Hang out with me!",'
        '"location":"IMA tennis court",'
        '"max":3,'
        '"startTime":"2024-01-04T15:14:15.537017Z",'
        '"endTime":"2023-11-04T16:14:15.567017Z",'
        '"hostId":2,'
        '"attendees":[3]}]');
  });

  test('GET events with id param', () async {
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
      Uri.parse('$host/events/get?id=0'),
    );
    expect(response.statusCode, 200);
    expect(response.body,
        '{"id":0,'
        '"title":"Tennis",'
        '"desc":"At the IMA tennis court! Hang out with me!",'
        '"location":"IMA tennis court",'
        '"max":3,'
        '"startTime":"2024-01-04T15:14:15.537017Z",'
        '"endTime":"2023-11-04T16:14:15.567017Z",'
        '"hostId":2,'
        '"attendees":[3]}');
  });

  test('GET events with bad id', () async {
    final response = await get(
      Uri.parse('$host/events/get?id=999'),
    );
    expect(response.statusCode, 400);
  });
}

void userRouteTests(String host) {
  test('GET user profile', () async {
    final response = await get(
      Uri.parse('$host/users/profile/get?id=1'),
    );
    expect(response.statusCode, 200);
    expect(response.body,
        '{"id":1,'
        '"firstName":"Fei",'
        '"lastName":"Huang",'
        '"year":4,'
        '"pronouns":"He/Him",'
        '"admin":true}');
  });

}