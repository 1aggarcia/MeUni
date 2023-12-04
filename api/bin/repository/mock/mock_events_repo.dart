import 'package:string_similarity/string_similarity.dart';

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
  Future<List<Event>> getUserEventsAsync(String userId) async {
    // Much harder to implement without user-events table
    // Possible but not worth the time
    return getEventsAsync();
  }

  @override
  Future<List<Event>> getHostEventsAsync(String userId) async {
    List<Event> all = await getEventsAsync();
    List<Event> result = [];

    for (Event event in all) {
      if (event.hostId == userId) {
        result.add(event);
      }
    }
    return result;
  }

  @override
  // Copy & paste from events_repo.dart
  Future<List<Event>> rankEventsAsync(String query) async {
    final List<Event> all = await getEventsAsync();
    final List<Event> result = [];

    for (Event event in all) {
      if (scoreEvent(event, query) > 0) {
        result.add(event);
      }
    }

    result.sort((a, b) => compareScore(a, b, query));
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

  /// Comparator function to sort a list of events by score of relevance to given query
  int compareScore(Event a, Event b, String query) {
    return scoreEvent(b, query).compareTo(scoreEvent(a, query));
  }

  /// Assign the given event a score of relevance to the given query (case insensitive)
  /// * if query has less than 2 characters, score = 0
  /// * if query has an exact match in event text, score = 1
  /// * otherwise, score = string similarity based on Dice's Coefficient, between 0-1
  double scoreEvent(Event event, String query) {
    if (query.length < 2) {
      return 0;
    }
    final String lowerQuery = query.toLowerCase();
    final String lowerTitle = event.title.toLowerCase();
    final String lowerDesc = event.desc.toLowerCase();
    final String lowerLoc = event.location.toLowerCase();

    if ((lowerTitle + lowerDesc + lowerLoc).contains(lowerQuery)) {
      return 1;
    } else {
      final double titleScore = lowerTitle.similarityTo(lowerQuery) *titleSearchWeight;
      final double descScore = lowerDesc.similarityTo(lowerQuery) *descSearchWeight;
      final double locScore = lowerLoc.similarityTo(lowerQuery) *locSearchWeight;
      return (titleScore + descScore + locScore) / 3;
    }
  }
}
