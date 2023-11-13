import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../../bin/controllers/event_controller.dart';
import '../../bin/locator.dart';
import '../../bin/models/event.dart';
import '../../bin/repository/events_repo.dart';
import '../../bin/repository/mock/mock_events_repo.dart';

final String _mockEvents =
    '{"id":-3,"title":"Pizza","desc":"need ppl to chip in for pizza","location":"The crib","max":4,"startTime":"2023-11-04T03:04:15.537017Z","endTime":"2023-11-04T03:24:15.537017Z","hostId":1,"hostName":"Fei","attendees":[2,3],"attendeeNames":["John","Hannah"]},{"id":-2,"title":"Event 1","desc":"This is a sample description for this event","location":"UW CSE2 G21","max":3,"startTime":"2023-11-04T02:24:25.537017Z","endTime":"2023-11-07T03:24:15.537017Z","hostId":2,"hostName":"John","attendees":[1,3],"attendeeNames":["Fei","Hannah"]},{"id":-1,"title":"Another event","desc":"This time i really need people","location":"[Redacted]","max":2,"startTime":"2023-11-05T03:04:15.537017Z","endTime":"2023-11-05T03:24:15.537017Z","hostId":3,"hostName":"Hannah","attendees":[1],"attendeeNames":["Fei"]}';
final String _rndUrl = 'https://example.com';

EventController _controller = EventController();

void main() {
  group('Events Controller -', () {
    setUp(() async {
      locator.reset();

      locator.registerLazySingleton<EventsRepo>(() => MockEventsRepo());

      MockEventsRepo mockEventsRepo = locator<EventsRepo>() as MockEventsRepo;
      mockEventsRepo.resetEvents();

      _controller = EventController();
    });

    test('POST events', () async {
      Event event = Event(
        id: -3,
        title: 'Pizza',
        desc: 'need ppl to chip in for pizza',
        location: 'The crib',
        max: 4,
        startTime: DateTime.parse('2023-11-04T03:04:15.537017Z'),
        endTime: DateTime.parse('2023-11-04T03:24:15.537017Z'),
        hostId: 1,
        hostName: 'Fei',
        attendees: [],
        attendeeNames: [],
      );

      String eventJson = eventToJson(event);
      expect(
          eventJson,
          '{"id":-3,'
          '"title":"Pizza",'
          '"desc":"need ppl to chip in for pizza",'
          '"location":"The crib",'
          '"max":4,'
          '"startTime":"2023-11-04T03:04:15.537017Z",'
          '"endTime":"2023-11-04T03:24:15.537017Z",'
          '"hostId":1,'
          '"hostName":"Fei",'
          '"attendees":[],'
          '"attendeeNames":[]}');

      Request req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/create'),
        body: eventJson,
      );
      Response response = await _controller.postEventsHandler(req);

      expect(response.statusCode, 200);

      expect(
          await response.readAsString(),
          '{"id":0,'
          '"title":"Pizza",'
          '"desc":"need ppl to chip in for pizza",'
          '"location":"The crib",'
          '"max":4,'
          '"startTime":"2023-11-04T03:04:15.537017Z",'
          '"endTime":"2023-11-04T03:24:15.537017Z",'
          '"hostId":1,'
          '"hostName":"Fei",'
          '"attendees":[],'
          '"attendeeNames":[]}');
    });

    test('POST with no body', () async {
      Request req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/create'),
      );
      Response response = await _controller.postEventsHandler(req);

      expect(response.statusCode, 400);
    });

    test('POST events with wrong types', () async {
      String eventJson = '{"title":0,'
          '"desc":"need ppl to chip in for pizza",'
          '"location":"The crib",'
          '"max":"",'
          '"startTime":"12/25/23",'
          '"endTime":"2023-11-04T03:24:15.537017Z",'
          '"hostId":1,'
          '"attendees":25}';

      Request req = Request(
        'POST',
        Uri.parse('$_rndUrl/events/create'),
        body: eventJson,
      );
      Response response = await _controller.postEventsHandler(req);

      expect(response.statusCode, 400);
    });

    test('GET events no params', () async {
      Event event = Event(
        id: -3,
        title: 'Tennis',
        desc: 'At the IMA tennis court! Hang out with me!',
        location: 'IMA tennis court',
        max: 3,
        startTime: DateTime.parse('2024-01-04T15:14:15.537017Z'),
        endTime: DateTime.parse('2023-11-04T16:14:15.567017Z'),
        hostId: 2,
        hostName: 'John',
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
        Uri.parse('$_rndUrl/events/get'),
      );
      response = await _controller.getEventsHandler(req);

      expect(response.statusCode, 200);
      expect(
          await response.readAsString(),
          '[$_mockEvents,'
          '{"id":0,'
          '"title":"Tennis",'
          '"desc":"At the IMA tennis court! Hang out with me!",'
          '"location":"IMA tennis court",'
          '"max":3,'
          '"startTime":"2024-01-04T15:14:15.537017Z",'
          '"endTime":"2023-11-04T16:14:15.567017Z",'
          '"hostId":2,'
          '"hostName":"John",'
          '"attendees":[],'
          '"attendeeNames":[]}]');
    });

    test('GET events with id param', () async {
      Event event = Event(
        id: -3,
        title: 'Tennis',
        desc: 'At the IMA tennis court! Hang out with me!',
        location: 'IMA tennis court',
        max: 3,
        startTime: DateTime.parse('2024-01-04T15:14:15.537017Z'),
        endTime: DateTime.parse('2023-11-04T16:14:15.567017Z'),
        hostId: 2,
        hostName: 'John',
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
      expect(
          await response.readAsString(),
          '{"id":0,'
          '"title":"Tennis",'
          '"desc":"At the IMA tennis court! Hang out with me!",'
          '"location":"IMA tennis court",'
          '"max":3,'
          '"startTime":"2024-01-04T15:14:15.537017Z",'
          '"endTime":"2023-11-04T16:14:15.567017Z",'
          '"hostId":2,'
          '"hostName":"John",'
          '"attendees":[],'
          '"attendeeNames":[]}');
    });

    test('GET events with bad id', () async {
      Request req = Request(
        'GET',
        Uri.parse('$_rndUrl/events/get?id=999'),
      );
      Response response = await _controller.getEventsHandler(req);

      expect(response.statusCode, 400);
    });
  });
}
