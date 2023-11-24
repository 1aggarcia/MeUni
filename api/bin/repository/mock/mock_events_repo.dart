import '../../models/event.dart';
import '../events_repo.dart';

class MockEventsRepo extends EventsRepo {
  //* Private Properties
  int _nextId = 0;
  Map<String, Event> _events = {};

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
      '-3': Event(
        id: '-3',
        title: 'Pizza',
        desc: 'need ppl to chip in for pizza',
        location: 'The crib',
        max: 4,
        startTime: DateTime.parse('2023-11-04 03:04:15.537017Z'),
        endTime: DateTime.parse('2023-11-04 03:24:15.537017Z'),
        hostName: 'Fei',
        hostId: '1',
        attendees: ['2', '3'],
        attendeeNames: ['John', 'Hannah'],
      ),
      '-2': Event(
        id: '-2',
        title: 'Event 1',
        desc: 'This is a sample description for this event',
        location: 'UW CSE2 G21',
        max: 3,
        startTime: DateTime.parse('2023-11-04 02:24:25.537017Z'),
        endTime: DateTime.parse('2023-11-07 03:24:15.537017Z'),
        hostId: '2',
        hostName: 'John',
        attendees: ['1', '3'],
        attendeeNames: ['Fei', 'Hannah'],
      ),
      '-1': Event(
        id: '-1',
        title: 'Another event',
        desc: 'This time i really need people',
        location: '[Redacted]',
        max: 2,
        startTime: DateTime.parse('2023-11-05 03:04:15.537017Z'),
        endTime: DateTime.parse('2023-11-05 03:24:15.537017Z'),
        hostId: '3',
        hostName: 'Hannah',
        attendees: ['1'],
        attendeeNames: ['Fei'],
      ),
    };
  }

  //* Overriden Methods
  @override
  Future<String> addEventAsync(Event event) async {
    _events['$_nextId'] = event;
    _nextId++;
    return '${_nextId - 1}';
  }

  @override
  Future<String> deleteEventAsync(String id) async {
    _events.remove(id);
    return id;
  }

  @override
  Future<Event?> getEventAsync(String id) async {
    return _events[id];
  }

  @override
  Future<List<Event>> getEventsAsync() async {
    List<Event> list = [];
    _events.forEach((k, v) {
      v.id = k;
      list.add(v);
    });
    return list;
  }

  @override
  Future<List<Event>> searchEventsAsync(String query) async {
    final String lowerQuery = query.toLowerCase();
    final List<Event> all = await getEventsAsync();
    final List<Event> result = [];

    String eventText;
    for (Event event in all) {
      eventText = (event.title + event.desc).toLowerCase();
      if (eventText.contains(lowerQuery)) {
        result.add(event);
      }
    }
    return result;
  }

  @override
  Future<List<String>?> joinEventAsync(String userId, String eventId) async {
    Event? event = _events[eventId];
    if (event == null ||
        event.attendees.contains(userId) ||
        event.attendees.length >= event.max) {
      return null;
    } else {
      event.attendees.add(userId);
      event.attendeeNames.add(userNamefromId(userId));
      return event.attendees;
    }
  }

  @override
  Future<List<String>?> unjoinEventAsync(String userId, String eventId) async {
    Event? event = _events[eventId];
    if (event == null) {
      return null;
    } else {
      event.attendees.remove(userId);
      return event.attendees;
    }
  }
}
