import '../../app/app.dart';
import '../../models/event.dart';
import '../events_repo.dart';

class MockEventsRepo extends EventsRepo {
  //* Private Properties
  List<Event> _events = [];

  //* Constructors
  MockEventsRepo() {
    _events = [
      Event(
        id: '1',
        title: 'Pizza',
        desc: 'need ppl to chip in for pizza',
        location: 'The crib',
        max: 4,
        startTime: DateTime.parse('2023-11-04 03:04:15.537017Z'),
        endTime: DateTime.parse('2023-11-04 03:24:15.537017Z'),
        hostName: 'Fei',
        hostId: 1,
        attendees: ['2', '3'],
      ),
      Event(
        id: '2',
        title: 'Event 1',
        desc: 'This is a sample description for this event',
        location: 'UW CSE2 G21',
        max: 3,
        startTime: DateTime.parse('2023-11-04 02:24:25.537017Z'),
        endTime: DateTime.parse('2023-11-07 03:24:15.537017Z'),
        hostId: 2,
        hostName: 'John',
        attendees: ['1', '3'],
      ),
      Event(
        id: '3',
        title: 'Another event',
        desc: 'This time i really need people',
        location: '[Redacted]',
        max: 2,
        startTime: DateTime.parse('2023-11-05 03:04:15.537017Z'),
        endTime: DateTime.parse('2023-11-05 03:24:15.537017Z'),
        hostId: 3,
        hostName: 'Hannah',
        attendees: ['1'],
      ),
    ];
  }

  //* Public Properties
  @override
  Future<List<Event>> getEventsAsync() async {
    await Future.delayed(App.demoDuration);

    return _events;
  }

  @override
  Future addEventAsync(Event event) async {
    await Future.delayed(App.demoDuration);

    _events.add(event);
  }
}
