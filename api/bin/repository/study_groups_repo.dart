import 'package:firebase_dart/database.dart' as db;

import '../locator.dart';
import '../models/study_group.dart';

abstract class StudyGroupsRepo {
  //* Public Methods

  // Returns the ID of the newly created studyGroup
  Future<int> addStudyGroupAsync(StudyGroup studyGroup);

  Future<int> deleteStudyGroupAsync(int id);

  /// Returns the StudyGroup if found, null otherwise
  Future<StudyGroup?> getStudyGroupAsync(int id);

  /// Returns {} if no studyGroup
  Future<Map<int, StudyGroup>> getStudyGroupsAsync();
}

class StudyGroupReposImpl extends StudyGroupsRepo {
  //* Private Properties
  late db.DatabaseReference _studyGroupsRef;

  //* Constructors
  StudyGroupReposImpl() {
    final dbRef = locator<db.DatabaseReference>();

    _studyGroupsRef = dbRef.child('studyGroups');
  }

  //* Overriden Methods
  @override
  Future<int> addStudyGroupAsync(StudyGroup studyGroup) {
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
    final db.DataSnapshot snapshot = await _studyGroupsRef.once();
    print(snapshot.value);

    final Map<String, Object>? value = snapshot.value;

    if (value != null) {
      // TODO: Convert Map<String, Object> to Map<int, StudyGroup>
      throw UnimplementedError();
    } else {
      return {};
    }
  }

  @override
  Future<int> deleteStudyGroupAsync(int id) {
    // TODO: implement deleteStudyGroupAsync
    throw UnimplementedError();
  }
}
