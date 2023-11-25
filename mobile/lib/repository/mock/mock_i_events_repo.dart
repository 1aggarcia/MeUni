import '../../app/app.dart';
import '../../app/app.locator.dart';
import '../../models/event.dart';
import '../../models/i_event.dart';
import '../../models/study_group.dart';
import '../../services/auth_service.dart';
import '../i_events_repo.dart';

class MockIEventsRepo<T extends IEvent> extends IEventsRepo<T> {
  //* Private Properties
  int _nextId = 1;
  List<IEvent> _iEvents = [];

  final _authService = locator<AuthService>();

  //* Constructors
  MockIEventsRepo() {
    _iEvents = T == Event ? _getMockEvents() : _getMockStudyGroups();
  }

  //* Overridden Methods
  @override
  Future<IEvent?> getIEventAsync(String id) async {
    await Future.delayed(App.demoDuration);

    try {
      return _iEvents.singleWhere((e) => e.id == id);
    } catch (ex) {
      return null;
    }
  }

  @override
  Future<List<IEvent>> getIEventsAsync({String? searchQuery}) async {
    await Future.delayed(App.demoDuration);

    if (searchQuery == null) {
      return _iEvents;
    }

    // Filter IEvents based on search query
    return _iEvents.where((e) => e.title.contains(searchQuery)).toList();
  }

  @override
  Future<bool> addIEventAsync({
    required String title,
    required String desc,
    required String location,
    required int max,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    await Future.delayed(App.demoDuration);

    IEvent iEvent;
    if (T == Event) {
      iEvent = Event(
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
    } else {
      iEvent = StudyGroup(
        id: '${_nextId++}',
        course: title,
        desc: desc,
        location: location,
        max: max,
        startTime: startTime,
        endTime: endTime,
        hostId: _authService.currUser.id,
        hostName: _authService.currUser.fullName,
        attendees: [],
      );
    }

    _iEvents.add(iEvent);

    return true;
  }

  @override
  Future<bool> joinIEventAsync(String id) async {
    IEvent? iEvent = await getIEventAsync(id);

    if (iEvent == null) {
      return false;
    } else if (iEvent.attendees.contains(_authService.currUser.id)) {
      return false;
    }

    iEvent.attendees.add(_authService.currUser.id);
    return true;
  }

  @override
  Future<bool> unJoinIEventAsync(String id) async {
    IEvent? iEvent = await getIEventAsync(id);

    if (iEvent == null) {
      return false;
    }

    return iEvent.attendees.remove(_authService.currUser.id);
  }

  //* Private Methods
  List<Event> _getMockEvents() {
    return [
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

  List<StudyGroup> _getMockStudyGroups() {
    return [
      StudyGroup(
        id: '1',
        course: 'CSE 403',
        desc: '403 study group!',
        location: 'The crib',
        max: 4,
        startTime: DateTime.parse('2023-11-04 03:04:15.537017Z'),
        endTime: DateTime.parse('2023-11-04 03:24:15.537017Z'),
        hostName: 'Fei',
        hostId: '1',
        attendees: ['2', '3'],
      ),
      StudyGroup(
        id: '2',
        course: 'CSE 421',
        desc: 'This is a sample description for this study group',
        location: 'UW CSE2 G21',
        max: 3,
        startTime: DateTime.parse('2023-11-04 02:24:25.537017Z'),
        endTime: DateTime.parse('2023-11-07 03:24:15.537017Z'),
        hostId: '2',
        hostName: 'John',
        attendees: ['1', '3'],
      ),
      StudyGroup(
        id: '3',
        course: 'CSE 553',
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
}
