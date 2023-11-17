import 'package:firebase_dart/database.dart' as db;

import '../locator.dart';
import '../models/studygroup.dart';

abstract class StudyGroupRepo {
  //* Public Methods

  // Returns the ID of the newly created studygroup
  Future<int> addStudyGroupAsync(StudyGroup studygroup);

  /// Returns the StudyGroup if found, null otherwise
  Future<StudyGroup?> getStudyGroupAsync(int id);

  /// Returns {} if no studygroups
  Future<Map<int, StudyGroup>> getStudyGroupsAsync();
}

class StudyGroupRepoImpl extends StudyGroupRepo {
  //* Private Properties
  late db.DatabaseReference _studygroupsRef;

  //* Constructors
  StudyGroupsRepoImpl() {
    final dbRef = locator<db.DatabaseReference>();

    _studygroupsRef = dbRef.child('studygroups');
  }

  //* Overriden Methods
  @override
  Future<int> addStudyGroupAsync(StudyGroup studygroup) {
    // TODO: implement addStudyGroupAsync
    throw UnimplementedError();
  }

  @override
  Future<StudyGroup> getStudyGroupAsync(int id) {
    // TODO: implement getStudyGroupAsync
    throw UnimplementedError();
  }

  @override
  Future<Map<int, StudyGroup>> getStudyGroupsAsync() async {
    final db.DataSnapshot snapshot = await _studygroupsRef.once();
    print(snapshot.value);

    final Map<String, Object>? value = snapshot.value;

    if (value != null) {
      // TODO: Convert Map<String, Object> to Map<int, StudyGroup>
      throw UnimplementedError();
    } else {
      return {};
    }
  }
}
