import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../../bin/controllers/event_controller.dart';
import '../../bin/locator.dart';
import '../../bin/models/event.dart';
import '../../bin/repository/events_repo.dart';
import '../../bin/repository/mock/mock_events_repo.dart';

final String _mockEvents =
    '{"id":-3,"title":"Pizza","desc":"need ppl to chip in for pizza","location":"The crib","max":4,"startTime":"2023-11-04T03:04:15.537017Z","endTime":"2023-11-04T03:24:15.537017Z","hostId":1,"hostName":"Fei","attendees":[2,3],"attendeeNames":["John","Hannah"]},{"id":-2,"title":"Event 1","desc":"This is a sample description for this event","location":"UW CSE2 G21","max":3,"startTime":"2023-11-04T02:24:25.537017Z","endTime":"2023-11-07T03:24:15.537017Z","hostId":2,"hostName":"John","attendees":[1,3],"attendeeNames":["Fei","Hannah"]},{"id":-1,"title":"Another event","desc":"This time i really need people","location":"[Redacted]","max":2,"startTime":"2023-11-05T03:04:15.537017Z","endTime":"2023-11-05T03:24:15.537017Z","hostId":3,"hostName":"Hannah","attendees":[1],"attendeeNames":["Fei"]}';

EventController _controller = EventController();
void main() {
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
      'GET',
      Uri.parse('https://example.com/events/create'),
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
}
