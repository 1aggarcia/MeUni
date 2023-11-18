import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../../bin/controllers/event_controller.dart';
import '../../bin/locator.dart';
import '../../bin/models/event.dart';
import '../../bin/repository/events_repo.dart';
import '../../bin/repository/mock/mock_events_repo.dart';

final String _rndUrl = 'https://example.com';

EventController _controller = EventController();

void main() {
  group('Events Controller -', () {
    setUp(() async {
      locator.reset();

      locator.registerLazySingleton<EventsRepo>(() => MockEventsRepo());

      MockEventsRepo mockEventsRepo = locator<EventsRepo>() as MockEventsRepo;
      mockEventsRepo.clearEvents();

      _controller = EventController();
    });

    Event event = Event(
      title: 'Pizza',
      desc: 'need ppl to chip in for pizza',
      location: 'The crib',
      max: 4,
      startTime: DateTime.parse('2023-11-04T03:04:15.537017Z'),
      endTime: DateTime.parse('2023-11-04T03:24:15.537017Z'),
      hostId: "1a",
      hostName: 'Fei',
      attendees: [],
      attendeeNames: [],
    );
    Event tennisEvent = Event(
      title: 'Tennis',
      desc: 'At the IMA tennis court! Hang out with me!',
      location: 'IMA tennis court',
      max: 3,
      startTime: DateTime.parse('2024-01-04T15:14:15.537017Z'),
      endTime: DateTime.parse('2023-11-04T16:14:15.567017Z'),
      hostId: "2b",
      hostName: '[unknown user]',
      attendees: [],
      attendeeNames: [],
    );
    Event dingDongEvent = Event(
      title: 'Ding Dong Ditching',
      desc: 'Lets go make my neighbors mad!',
      location: 'Community Center',
      max: 5,
      startTime: DateTime.parse('2024-08-04T15:14:15.537017Z'),
      endTime: DateTime.parse('2024-08-04T16:14:59.567017Z'),
      hostId: "3b",
      hostName: '[unknown user]',
      attendees: [],
      attendeeNames: [],
    );

    String eventJson = eventToJson(event);
    String tennisJson = eventToJson(tennisEvent);
    String dingDongJson = eventToJson(dingDongEvent);

    test('events/create', () async {
      Request req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/create'),
        body: eventJson,
      );
      Response response = await _controller.postEventsHandler(req);
      expect(response.statusCode, 200);

      expect(await response.readAsString(),"0");
    });

    test('events/create with no body', () async {
      Request req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/create'),
      );
      Response response = await _controller.postEventsHandler(req);

      expect(response.statusCode, 400);
    });

    test('events/create with wrong types', () async {
      String eventJson = 
          '{"title":0,'
          '"desc":"need ppl to chip in for pizza",'
          '"location":"The crib",'
          '"max":"",'
          '"startTime":"12/25/23",'
          '"endTime":"2023-11-04T03:24:15.537017Z",'
          '"hostId":"1a",'
          '"attendees":25}';

      Request req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/create'),
        body: eventJson,
      );
      Response response = await _controller.postEventsHandler(req);

      expect(response.statusCode, 400);
    });

    test('events/get no params', () async {
      Request req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/create'),
        body: tennisJson,
      );
      Response response = await _controller.postEventsHandler(req);
      expect(response.statusCode, 200);

      req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/create'),
        body: dingDongJson,
      );
      response = await _controller.postEventsHandler(req);
      expect(response.statusCode, 200);

      req = Request(
        'GET',
        Uri.parse('$_rndUrl/events/get'),
      );
      response = await _controller.getEventsHandler(req);

      expect(response.statusCode, 200);
      expect(eventsToJson({
        "0":tennisEvent,
        "1":dingDongEvent
      }),
          await response.readAsString());
    });

    test('events/get with id param', () async {
      Event event = Event(
        title: 'Tennis',
        desc: 'At the IMA tennis court! Hang out with me!',
        location: 'IMA tennis court',
        max: 3,
        startTime: DateTime.parse('2024-01-04T15:14:15.537017Z'),
        endTime: DateTime.parse('2023-11-04T16:14:15.567017Z'),
        hostId: "2b",
        hostName: '[unknown user]',
        attendees: [],
        attendeeNames: [],
      );
      String eventJson = eventToJson(event);

      Request req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/create'),
        body: eventJson,
      );
      Response response = await _controller.postEventsHandler(req);
      expect(response.statusCode, 200);

      req = Request(
        'GET',
        Uri.parse('$_rndUrl/events/get?id=0'),
      );
      response = await _controller.getEventsHandler(req);

      expect(response.statusCode, 200);
      expect(eventJson,
          await response.readAsString());
    });

    test('events/get with bad id', () async {
      Request req = Request(
        'GET',
        Uri.parse('$_rndUrl/events/get?id=999'),
      );
      Response response = await _controller.getEventsHandler(req);
      expect(response.statusCode, 400);
    });

    test('events/delete', () async {
      // Create event
      Request req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/create'),
        body: eventJson,
      );
      Response response = await _controller.postEventsHandler(req);
      expect(response.statusCode, 200);

      // Delete event
      req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/delete'),
        body: '{"id":"0"}',
      );
      response = await _controller.deleteEventsHandler(req);
      expect(response.statusCode, 200);
      expect(await response.readAsString(),"0");

      // Verify event no longer in dataase
      req = Request(
        'GET',
        Uri.parse('$_rndUrl/events/get?id=0'),
      );
      response = await _controller.getEventsHandler(req);
      expect(response.statusCode, 400);
    });

    test('events/join', () async {
      // Create event
      Request req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/create'),
        body: eventJson,
      );
      Response response = await _controller.postEventsHandler(req);
      expect(response.statusCode, 200);

      // Join event
      req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/delete'),
        body: '{"userId":"2c","eventId":"0"}',
      );
      response = await _controller.joinEventsHandler(req);
      expect(response.statusCode, 200);
      expect(await response.readAsString(),'["2c"]');
    });

    test('events/join - user already in event', () async {
      // Create event
      Request req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/create'),
        body: eventJson,
      );
      Response response = await _controller.postEventsHandler(req);
      expect(response.statusCode, 200);

      // Join event twice
      req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/delete'),
        body: '{"userId":"2c","eventId":0}',
      );
      response = await _controller.joinEventsHandler(req);

      req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/delete'),
        body: '{"userId":"2c","eventId":0}',
      );
      response = await _controller.joinEventsHandler(req);
      expect(response.statusCode, 400);
    });

    test('events/join - invalid event', () async {
      Request req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/delete'),
        body: '{"userId":"2c","eventId":235}',
      );
      Response response = await _controller.joinEventsHandler(req);
      expect(response.statusCode, 400);
    });

    test('events/join - over capacity', () async {
      // Create event
      Event event = Event(
        title: 'Pizza',
        desc: 'need ppl to chip in for pizza',
        location: 'The crib',
        max: 1,
        startTime: DateTime.parse('2023-11-04T03:04:15.537017Z'),
        endTime: DateTime.parse('2023-11-04T03:24:15.537017Z'),
        hostId: "1a",
        hostName: 'Fei',
        attendees: [],
        attendeeNames: [],
      );
      String eventJson = eventToJson(event);

      Request req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/create'),
        body: eventJson,
      );
      Response response = await _controller.postEventsHandler(req);
      expect(response.statusCode, 200);

      // Exceed capacity
      req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/delete'),
        body: '{"userId":"ff","eventId":0}',
      );
      response = await _controller.joinEventsHandler(req);

      req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/delete'),
        body: '{"userId":"2c","eventId":0}',
      );
      response = await _controller.joinEventsHandler(req);
      expect(response.statusCode, 400);
    });
  });
}
