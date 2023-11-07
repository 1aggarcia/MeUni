import '../models/event.dart';

class MockEventsRepo {

  List<Event> getMockEvents() {
    return mockEvents;
  }

  final List<Event> mockEvents = [
        Event(
            id: -3,
            title: 'Pizza',
            desc: 'need ppl to chip in for pizza',
            location: 'The crib',
            max: 4,
            startTime: DateTime.parse('2023-11-04 03:04:15.537017Z'),
            endTime: DateTime.parse('2023-11-04 03:24:15.537017Z'),
            hostName: 'Fei',
            hostId: 1,
            attendees: [2, 3],
            attendeeNames: ['John', 'Hannah']),
        Event(
            id: -2,
            title: 'Event 1',
            desc: 'This is a sample description for this event',
            location: 'UW CSE2 G21',
            max: 3,
            startTime: DateTime.parse('2023-11-04 02:24:25.537017Z'),
            endTime: DateTime.parse('2023-11-07 03:24:15.537017Z'),
            hostId: 2,
            hostName: 'John',
            attendees: [1, 3],
            attendeeNames: ['Fei', 'Hannah']),
        Event(
            id: -1,
            title: 'Another event',
            desc: 'This time i really need people',
            location: '[Redacted]',
            max: 2,
            startTime: DateTime.parse('2023-11-05 03:04:15.537017Z'),
            endTime: DateTime.parse('2023-11-05 03:24:15.537017Z'),
            hostId: 3,
            hostName: 'Hannah',
            attendees: [1],
            attendeeNames: ['Fei']),
      ];
}