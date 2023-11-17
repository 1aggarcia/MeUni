import '../../models/studygroup.dart';
import '../studygroup_repo.dart';
import '../studygroup_repo.dart';

class MockStudyGroupRepo extends StudyGroupRepo {
  //* Private Properties
  int _nextId = 0;
  Map<int, StudyGroup> _studygroups = {};

  //* Constructors
  MockStudyGroupRepo() {
    resetStudyGroups();
  }

  //* Public Methods
  void clearStudyGroups() {
    _nextId = 0;
    _studygroups = {};
  }

  void resetStudyGroups() {
    _nextId = 0;
    _studygroups = {
      -3:StudyGroup(
        course: 'Pizza',
        desc: 'need ppl to chip in for pizza',
        location: 'The crib',
        max: 4,
        startTime: DateTime.parse('2023-11-04 03:04:15.537017Z'),
        endTime: DateTime.parse('2023-11-04 03:24:15.537017Z'),
        hostName: 'Fei',
        hostId: 1,
        attendees: [2, 3],
      ),
      -2:StudyGroup(
        course: 'Event 1',
        desc: 'This is a sample description for this event',
        location: 'UW CSE2 G21',
        max: 3,
        startTime: DateTime.parse('2023-11-04 02:24:25.537017Z'),
        endTime: DateTime.parse('2023-11-07 03:24:15.537017Z'),
        hostId: 2,
        hostName: 'John',
        attendees: [1, 3],
      ),
      -1:StudyGroup(
        course: 'Another event',
        desc: 'This time i really need people',
        location: '[Redacted]',
        max: 2,
        startTime: DateTime.parse('2023-11-05 03:04:15.537017Z'),
        endTime: DateTime.parse('2023-11-05 03:24:15.537017Z'),
        hostId: 3,
        hostName: 'Hannah',
        attendees: [1],
      ),
    };
  }

  //* Overriden Methods
  @override
  Future<int> addStudyGroupAsync(StudyGroup studyGroup) async {
    _studygroups[_nextId] = studyGroup;
    _nextId++;

    return _nextId - 1;
  }

  @override
  int deleteStudyGroupAsync(int id) {
    _studygroups.remove(id);
    return id;
  }

  @override
  Future<StudyGroup?> getStudyGroupAsync(int id) async {
    return _studygroups[id];
  }

  @override
  Future<Map<int, StudyGroup>> getStudyGroupsAsync() async {
    return _studygroups;
  }
}
