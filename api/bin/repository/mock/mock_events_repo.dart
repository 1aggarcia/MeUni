import '../../models/event.dart';
import '../events_repo.dart';

class MockEventsRepo extends EventsRepo {
  //* Private Properties
  int _nextId = 0;
  Map<int, Event> _events = {};

  //* Constructors
  MockEventsRepo() {
    resetEvents();
  }

  //* Public Methods
  void clearEvents() {
    _nextId = 0;
    _events = {};
  }

  void resetEvents() {
    _nextId = 0;
    _events = {
      -3:Event(
        title: 'Pizza',
        desc: 'need ppl to chip in for pizza',
        location: 'The crib',
        max: 4,
        startTime: DateTime.parse('2023-11-04 03:04:15.537017Z'),
        endTime: DateTime.parse('2023-11-04 03:24:15.537017Z'),
        hostName: 'Fei',
        hostId: 1,
        attendees: [2, 3],
        attendeeNames: ['John', 'Hannah'],
      ),
      -2:Event(
        title: 'Event 1',
        desc: 'This is a sample description for this event',
        location: 'UW CSE2 G21',
        max: 3,
        startTime: DateTime.parse('2023-11-04 02:24:25.537017Z'),
        endTime: DateTime.parse('2023-11-07 03:24:15.537017Z'),
        hostId: 2,
        hostName: 'John',
        attendees: [1, 3],
        attendeeNames: ['Fei', 'Hannah'],
      ),
      -1:Event(
        title: 'Another event',
        desc: 'This time i really need people',
        location: '[Redacted]',
        max: 2,
        startTime: DateTime.parse('2023-11-05 03:04:15.537017Z'),
        endTime: DateTime.parse('2023-11-05 03:24:15.537017Z'),
        hostId: 3,
        hostName: 'Hannah',
        attendees: [1],
        attendeeNames: ['Fei'],
      ),
    };
  }

  //* Overriden Methods
  @override
  Future<int> addEventAsync(Event event) async {
    // Event newEvent = Event(
    //   title: event.title,
    //   desc: event.desc,
    //   location: event.location,
    //   max: event.max,
    //   startTime: event.startTime,
    //   endTime: event.endTime,
    //   hostId: event.hostId,
    //   hostName: event.hostName,
    //   attendees: event.attendees,
    //   attendeeNames: event.attendeeNames,
    // );
    _events[_nextId] = event;
    _nextId++;

    return _nextId - 1;
  }

  @override
  int deleteEventAsync(int id) {
    _events.remove(id);
    return id;
  }

  @override
  Future<Event?> getEventAsync(int id) async {
    return _events[id];
  }

  @override
  Future<Map<int, Event>> getEventsAsync() async {
    return _events;
  }
}
