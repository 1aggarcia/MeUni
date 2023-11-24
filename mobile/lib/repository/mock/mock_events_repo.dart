import '../../app/app.dart';
import '../../app/app.locator.dart';
import '../../models/event.dart';
import '../../services/auth_service.dart';
import '../events_repo.dart';

class MockEventsRepo extends EventsRepo {
  //* Private Properties
  int _nextId = 1;
  List<Event> _events = [];

  final _authService = locator<AuthService>();

  //* Constructors
  MockEventsRepo() {
    _events = [
      Event(
        id: '${_nextId++}',
        title: 'Pizza',
        desc: 'need ppl to chip in for pizza',
        location: 'The crib',
        max: 4,
        startTime: DateTime.parse('2023-11-04 03:04:15.537017Z'),
        endTime: DateTime.parse('2023-11-04 03:24:15.537017Z'),
        hostName: 'Fei',
        hostId: '1',
        attendees: ['2', '3'],
      ),
      Event(
        id: '${_nextId++}',
        title: 'Event 1',
        desc: 'This is a sample description for this event',
        location: 'UW CSE2 G21',
        max: 3,
        startTime: DateTime.parse('2023-11-04 02:24:25.537017Z'),
        endTime: DateTime.parse('2023-11-07 03:24:15.537017Z'),
        hostId: '2',
        hostName: 'John',
        attendees: ['1', '3'],
      ),
      Event(
        id: '${_nextId++}',
        title: 'Another event',
        desc: 'This time i really need people',
        location: '[Redacted]',
        max: 2,
        startTime: DateTime.parse('2023-11-05 03:04:15.537017Z'),
        endTime: DateTime.parse('2023-11-05 03:24:15.537017Z'),
        hostId: '3',
        hostName: 'Hannah',
        attendees: ['1'],
      ),
    ];
  }

  //* Overridden Methods
  @override
  Future<Event?> getEventAsync(String id) async {
    await Future.delayed(App.demoDuration);

    try {
      return _events.singleWhere((e) => e.id == id);
    } catch (ex) {
      return null;
    }
  }

  @override
  Future<List<Event>> getEventsAsync({String? searchQuery}) async {
    await Future.delayed(App.demoDuration);

    if (searchQuery == null) return _events;

    // Filter events based on search query
    return _events.where((e) => e.title.contains(searchQuery)).toList();
  }

  @override
  Future<bool> addEventAsync({
    required String title,
    required String desc,
    required String location,
    required int max,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    await Future.delayed(App.demoDuration);

    Event event = Event(
      id: '${_nextId++}',
      title: title,
      desc: desc,
      location: location,
      max: max,
      startTime: startTime,
      endTime: endTime,
      hostId: _authService.currUser.id,
      hostName: _authService.currUser.fullName,
      attendees: [],
    );

    _events.add(event);

    return true;
  }

  @override
  Future<bool> joinEventAsync(String id) async {
    Event? event = await getEventAsync(id);

    if (event == null) {
      return false;
    } else if (event.attendees.contains(_authService.currUser.id)) {
      return false;
    }

    event.attendees.add(_authService.currUser.id);
    return true;
  }

  @override
  Future<bool> unJoinEventAsync(String id) async {
    Event? event = await getEventAsync(id);

    if (event == null) {
      return false;
    }

    return event.attendees.remove(_authService.currUser.id);
  }
}
