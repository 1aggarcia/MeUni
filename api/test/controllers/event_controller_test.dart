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
  hostName: '[unknown]',
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
  hostName: '[unknown]',
  attendees: [],
  attendeeNames: [],
);
Event dingDongEvent = Event(
  id: '2',
  title: 'Ding Dong Ditching',
  desc: 'Hey, lets go make my neighbors mad!',
  location: 'Community Center',
  max: 5,
  startTime: DateTime.parse('2024-08-04T15:14:15.537017Z'),
  endTime: DateTime.parse('2024-08-04T16:14:59.567017Z'),
  hostId: '3b',
  hostName: '[unknown]',
  attendees: [],
  attendeeNames: [],
);

String eventJson = jsonEncode(event.toJsonFull());
String tennisJson = jsonEncode(tennisEvent.toJsonFull());
String dingDongJson = jsonEncode(dingDongEvent.toJsonFull());

Event searchLocEvent = Event(
  id: '0',
  title: '!',
  desc: '!',
  location: 'kEyWoRd',
  max: 5,
  startTime: DateTime.parse('2024-08-04T15:14:15.537017Z'),
  endTime: DateTime.parse('2024-08-04T16:14:59.567017Z'),
  hostId: '3b',
  hostName: '[unknown]',
  attendees: [],
  attendeeNames: [],
);
Event searchTitleEvent = Event(
  id: '1',
  title: 'KeYwOrD',
  desc: '!',
  location: '!',
  max: 5,
  startTime: DateTime.parse('2024-08-04T15:14:15.537017Z'),
  endTime: DateTime.parse('2024-08-04T16:14:59.567017Z'),
  hostId: '3b',
  hostName: '[unknown]',
  attendees: [],
  attendeeNames: [],
);
Event searchDescEvent = Event(
  id: '2',
  title: '!',
  desc: 'KEywORd',
  location: '!',
  max: 5,
  startTime: DateTime.parse('2024-08-04T15:14:15.537017Z'),
  endTime: DateTime.parse('2024-08-04T16:14:59.567017Z'),
  hostId: '3b',
  hostName: '[unknown]',
  attendees: [],
  attendeeNames: [],
);
Event searchMisspelledEvent = Event(
  id: '1',
  title: 'keywrod',
  desc: '!',
  location: '!',
  max: 5,
  startTime: DateTime.parse('2024-08-04T15:14:15.537017Z'),
  endTime: DateTime.parse('2024-08-04T16:14:59.567017Z'),
  hostId: '3b',
  hostName: '[unknown]',
  attendees: [],
  attendeeNames: [],
);

String searchLocJson = jsonEncode(searchLocEvent.toJsonFull());
String searchTitleJson = jsonEncode(searchTitleEvent.toJsonFull());
String searchDescJson = jsonEncode(searchDescEvent.toJsonFull());
String searchMisspelledJson = jsonEncode(searchMisspelledEvent.toJsonFull());

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

    Future<Response> sendGetRequest(String args, Function handler) async {
        Request req = Request(
          'GET',
          Uri.parse('$_rndUrl/events/$args'),
        );
        return await handler(req);
    }

    group('get:', () {
      test('no params', () async {
        Response response = await sendCreateRequest(eventJson);
        expect(response.statusCode, 200);

        response = await sendCreateRequest(tennisJson);
        expect(response.statusCode, 200);

        response = await sendCreateRequest(dingDongJson);
        expect(response.statusCode, 200);

        response = await sendGetRequest('get', _controller.getHandler);
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
          hostName: '[unknown]',
          attendees: [],
          attendeeNames: [],
        );
        String eventJson = eventToJson(event);

        Response response = await sendCreateRequest(eventJson);
        expect(response.statusCode, 200);

        response = await sendGetRequest('get?id=0', _controller.getHandler);
        expect(response.statusCode, 200);
        expect(eventJson, await response.readAsString());
      });

      test('bad id', () async {
        Response response = await sendGetRequest('get?id=999', _controller.getHandler);
        expect(response.statusCode, 404);
      });

      test('id and query param', () async {
        Response response = await sendGetRequest('get?id=0&query=kl', _controller.getHandler);
        expect(response.statusCode, 400);

        response = await sendGetRequest('get?query=asd&id=0', _controller.getHandler);
        expect(response.statusCode, 400);
      });

      test('search weighting', () async {
        // Create events
        Response response = await sendCreateRequest(searchLocJson);
        expect(response.statusCode, 200);

        response = await sendCreateRequest(searchTitleJson);
        expect(response.statusCode, 200);

        response = await sendCreateRequest(searchDescJson);
        expect(response.statusCode, 200);

        // Search
        response = await sendGetRequest('get?query=keywrd', _controller.getHandler);
        expect(response.statusCode, 200);
        expect(
          await response.readAsString(),
          eventsToJson([searchTitleEvent, searchDescEvent, searchLocEvent]),
        );
      });

      test('search excludes irrelevant events', () async {
        // Create events
        Response response = await sendCreateRequest(eventJson);
        expect(response.statusCode, 200);

        response = await sendCreateRequest(searchTitleJson);
        expect(response.statusCode, 200);

        // Search
        response = await sendGetRequest('get?query=pizza', _controller.getHandler);
        expect(response.statusCode, 200);
        expect(
          await response.readAsString(),
          eventsToJson([event]),
        );
      });

      test('search ranks exact matches highest', () async {
        // Create events
        Response response = await sendCreateRequest(searchLocJson);
        expect(response.statusCode, 200);

        response = await sendCreateRequest(searchMisspelledJson);
        expect(response.statusCode, 200);

        // Search
        response = await sendGetRequest('get?query=keyword', _controller.getHandler);
        expect(response.statusCode, 200);
        expect(
          await response.readAsString(),
          eventsToJson([searchLocEvent, searchMisspelledEvent]),
        );
      });
    });

    group('get (2):', () {
      test('user/get', () async {
        // output cant be tested due to lacking mock implementation, but I have manually tested it
        Response response = await sendGetRequest('user/get?id=3', _controller.userGetHandler);
        expect(response.statusCode, 200);

        response = await sendGetRequest('user/get?id=s234jf', _controller.userGetHandler);
        expect(response.statusCode, 200);
      });

      test('user/get - missing id param', () async {
        Response response = await sendGetRequest('user/get', _controller.userGetHandler);
        expect(response.statusCode, 400);

        response = await sendGetRequest('user/get?notid=34', _controller.userGetHandler);
        expect(response.statusCode, 400);
      });

      test('host/get', () async {
        // Create events
        Response response = await sendCreateRequest(eventJson); // host is not 3b
        expect(response.statusCode, 200);

        response = await sendCreateRequest(searchTitleJson); // host=3b
        expect(response.statusCode, 200);

        response = await sendCreateRequest(searchDescJson); // host=3b
        expect(response.statusCode, 200);
        
        // Get them
        response = await sendGetRequest('host/get?id=3b', _controller.hostGetHandler);
        expect(response.statusCode, 200);
        expect(await response.readAsString(), 
        eventsToJson([searchTitleEvent, searchDescEvent]));
      });

      test('host/get - no events', () async {
        Response response = await sendGetRequest('host/get?id=34', _controller.hostGetHandler);
        expect(response.statusCode, 200);

        response = await sendGetRequest('host/get?id=3sadf23', _controller.hostGetHandler);
        expect(response.statusCode, 200);
      });

      test('host/get - missing id param', () async {
        Response response = await sendGetRequest('user/get', _controller.hostGetHandler);
        expect(response.statusCode, 400);

        response = await sendGetRequest('user/get?notid=34', _controller.hostGetHandler);
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
      response = await sendGetRequest('get?id=0', _controller.getHandler);
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
