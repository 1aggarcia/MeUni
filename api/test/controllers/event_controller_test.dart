import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../../bin/controllers/event_study_controller.dart';
import '../../bin/locator.dart';
import '../../bin/models/event.dart';
import '../../bin/repository/events_repo.dart';
import '../../bin/repository/mock/mock_events_repo.dart';

final String _rndUrl = 'https://example.com';
final paramName = 'eventId';
final _eventsRepo = EventsRepoImpl('events', paramName);

EventStudyController _controller = EventStudyController(_eventsRepo, paramName);

Event event = Event(
  id: '0',
  title: 'Pizza',
  desc: 'need ppl to chip in for pizza',
  location: 'The crib',
  max: 4,
  startTime: DateTime.parse('2023-11-04T03:04:15.537017Z'),
  endTime: DateTime.parse('2023-11-04T03:24:15.537017Z'),
  hostId: '1a',
  hostName: '[unknown user]',
  attendees: [],
  attendeeNames: [],
);
Event tennisEvent = Event(
  id: '1',
  title: 'Tennis',
  desc: 'At the IMA tennis court! Hang out with me!',
  location: 'IMA tennis court',
  max: 3,
  startTime: DateTime.parse('2024-01-04T15:14:15.537017Z'),
  endTime: DateTime.parse('2023-11-04T16:14:15.567017Z'),
  hostId: '2b',
  hostName: '[unknown user]',
  attendees: [],
  attendeeNames: [],
);
Event dingDongEvent = Event(
  id: '2',
  title: 'Ding Dong Ditching',
  desc: 'Lets go make my neighbors mad!',
  location: 'Community Center',
  max: 5,
  startTime: DateTime.parse('2024-08-04T15:14:15.537017Z'),
  endTime: DateTime.parse('2024-08-04T16:14:59.567017Z'),
  hostId: '3b',
  hostName: '[unknown user]',
  attendees: [],
  attendeeNames: [],
);

String eventJson = jsonEncode(event.toJsonFull());
String tennisJson = jsonEncode(tennisEvent.toJsonFull());
String dingDongJson = jsonEncode(dingDongEvent.toJsonFull());

void main() {
  group('Event Study Controller -', () {
    setUp(() async {
      await locator.reset();

      locator.registerLazySingleton<EventsRepo>(MockEventsRepo.new);

      MockEventsRepo mockEventsRepo = locator<EventsRepo>() as MockEventsRepo;
      mockEventsRepo.clearEvents();

      _controller = EventStudyController(mockEventsRepo, paramName);
    });

    Future<Response> sendPostRequest(String route, String body, Function handler) async {
      Request req = Request(
        'POST',
        Uri.parse('$_rndUrl/$route'),
        body: body,
      );
      return await handler(req);         
    }

    Future<Response> sendCreateRequest(String body) async {
      return await sendPostRequest('events/create', body, _controller.createHandler); 
    }

    group('create:', () {

      test('good input', () async {
        Response response = await sendCreateRequest(eventJson);
        expect(response.statusCode, 200);
        expect(await response.readAsString(), '0');
      });

      test('no body', () async {
        Response response = await sendCreateRequest('');
        expect(response.statusCode, 400);
      });

      test('wrong types', () async {
        String badJson = '{"title":0,'
            '"desc":"need ppl to chip in for pizza",'
            '"location":"The crib",'
            '"max":"",'
            '"startTime":"12/25/23",'
            '"endTime":"2023-11-04T03:24:15.537017Z",'
            '"hostId":"1a",'
            '"attendees":25}';

        Response response = await sendCreateRequest(badJson);
        expect(response.statusCode, 400);
      });
    });

    Future<Response> sendGetRequest(String args) async {
        Request req = Request(
          'GET',
          Uri.parse('$_rndUrl/events/get$args'),
        );
        return await _controller.getHandler(req);
    }

    group('get:', () {
      test('no params', () async {
        Response response = await sendCreateRequest(eventJson);
        expect(response.statusCode, 200);

        response = await sendCreateRequest(tennisJson);
        expect(response.statusCode, 200);

        response = await sendCreateRequest(dingDongJson);
        expect(response.statusCode, 200);

        response = await sendGetRequest('');
        expect(response.statusCode, 200);
        expect(
          await response.readAsString(),
          eventsToJson([event, tennisEvent, dingDongEvent]),
        );
      });

      test('id param', () async {
        Event event = Event(
          title: 'Tennis',
          desc: 'At the IMA tennis court! Hang out with me!',
          location: 'IMA tennis court',
          max: 3,
          startTime: DateTime.parse('2024-01-04T15:14:15.537017Z'),
          endTime: DateTime.parse('2023-11-04T16:14:15.567017Z'),
          hostId: '2b',
          hostName: '[unknown user]',
          attendees: [],
          attendeeNames: [],
        );
        String eventJson = eventToJson(event);

        Response response = await sendCreateRequest(eventJson);
        expect(response.statusCode, 200);

        response = await sendGetRequest('?id=0');
        expect(response.statusCode, 200);
        expect(eventJson, await response.readAsString());
      });

      test('bad id', () async {
        Response response = await sendGetRequest('?id=999');
        expect(response.statusCode, 404);
      });

      test('id and query param', () async {
        Response response = await sendGetRequest('?id=0&query=kl');
        expect(response.statusCode, 400);

        response = await sendGetRequest('?query=asd&id=0');
        expect(response.statusCode, 400);
      });
    });

    Future<Response> sendDeleteRequest(String body) async {
      return await sendPostRequest('events/delete', body, _controller.deleteHandler);
    }

    test('delete', () async {
      // Create event
      Response response = await sendCreateRequest(eventJson);
      expect(response.statusCode, 200);
      expect(await response.readAsString(), '0');

      // Delete event
      response = await sendDeleteRequest('{"id":"0"}');
      expect(response.statusCode, 200);
      expect(await response.readAsString(), '0');

      // Verify event no longer in dataase
      response = await sendGetRequest('?id=0');
      expect(response.statusCode, 404);
    });

    Future<Response> sendJoinRequest(String body) async {
      return await sendPostRequest('events/join', body, _controller.joinHandler);
    }

    group('join:', () {
      test('good input', () async {
        // Create event
        Response response = await sendCreateRequest(eventJson);
        expect(response.statusCode, 200);

        // Join event
        response = await sendJoinRequest('{"userId":"2c","eventId":"0"}');
        expect(response.statusCode, 200);
        expect(await response.readAsString(), '["2c"]');
      });

      test('user already in event', () async {
        // Create event
        Response response = await sendCreateRequest(eventJson);
        expect(response.statusCode, 200);

        // Join event twice
        response = await sendJoinRequest('{"userId":"2c","eventId":"0"}');
        expect(response.statusCode, 200);

        response = await sendJoinRequest('{"userId":"2c","eventId":"0"}');
        expect(response.statusCode, 400);
      });

      test('invalid event', () async {
        Response response = await sendJoinRequest('{"userId":"2c","eventId":235}');
        expect(response.statusCode, 400);
      });

      test('over capacity', () async {
        // Create event
        Event event = Event(
          title: 'Pizza',
          desc: 'need ppl to chip in for pizza',
          location: 'The crib',
          max: 1,
          startTime: DateTime.parse('2023-11-04T03:04:15.537017Z'),
          endTime: DateTime.parse('2023-11-04T03:24:15.537017Z'),
          hostId: '1a',
          hostName: 'Fei',
          attendees: [],
          attendeeNames: [],
        );
        String eventJson = eventToJson(event);

        Response response = await sendCreateRequest(eventJson);
        expect(response.statusCode, 200);

        // Exceed capacity
        response = await sendJoinRequest('{"userId":"ff","eventId":"0"}');
        expect(response.statusCode, 200);

        response = await sendJoinRequest('{"userId":"2c","eventId":"0"}');
        expect(response.statusCode, 400);
      });
    });

    Future<Response> sendUnjoinRequest(String body) async {
      return await sendPostRequest('events/unjoin', body, _controller.unjoinHandler);
    }

    test('unjoin', () async {
      // Create event
      Response response = await sendCreateRequest(eventJson);
      expect(response.statusCode, 200);

      // Join event
      response = await sendJoinRequest('{"userId":"2c","eventId":"0"}');
      expect(response.statusCode, 200);
      expect(await response.readAsString(), '["2c"]');

      // Unoin event
      response = await sendUnjoinRequest('{"userId":"2c","eventId":"0"}');
      expect(response.statusCode, 200);
      expect(await response.readAsString(), '[]');
    });
  });
}
