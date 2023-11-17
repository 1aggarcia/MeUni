import '../../app/app.dart';
import '../../models/studygroup.dart';
import '../studygroup_repo.dart';

class MockStudyGroupRepo extends StudyGroupRepo {
  //* Private Properties
  List<StudyGroup> _studygroups = [];

  //* Constructors
  MockStudyGroupRepo() {
    _studygroups = [
      StudyGroup(
        id: 1,
        course: 'CSE 403',
        desc: '403 study group!',
        location: 'The crib',
        max: 4,
        startTime: DateTime.parse('2023-11-04 03:04:15.537017Z'),
        endTime: DateTime.parse('2023-11-04 03:24:15.537017Z'),
        hostName: 'Fei',
        hostId: 1,
        attendees: [2, 3],
      ),
      StudyGroup(
        id: 2,
        course: 'CSE 421',
        desc: 'This is a sample description for this study group',
        location: 'UW CSE2 G21',
        max: 3,
        startTime: DateTime.parse('2023-11-04 02:24:25.537017Z'),
        endTime: DateTime.parse('2023-11-07 03:24:15.537017Z'),
        hostId: 2,
        hostName: 'John',
        attendees: [1, 3],
      ),
      StudyGroup(
        id: 3,
        course: 'CSE 553',
        desc: 'This time i really need people',
        location: '[Redacted]',
        max: 2,
        startTime: DateTime.parse('2023-11-05 03:04:15.537017Z'),
        endTime: DateTime.parse('2023-11-05 03:24:15.537017Z'),
        hostId: 3,
        hostName: 'Hannah',
        attendees: [1],
      ),
    ];
  }

  //* Public Properties
  @override
  Future<List<StudyGroup>> getStudyGroupsAsync() async {
    await Future.delayed(App.demoDuration);

    return _studygroups;
  }

  @override
  Future addStudyGroupAsync(StudyGroup studyGroup) async {
    await Future.delayed(App.demoDuration);

    _studygroups.add(studyGroup);
  }
}
