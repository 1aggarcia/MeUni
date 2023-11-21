import 'dart:convert';

import 'package:http/http.dart';

import '../app/app.locator.dart';
import '../models/study_group.dart';
import '../services/api_service.dart';

abstract class StudyGroupsRepo {
  //* Public Methods
  Future<List<StudyGroup>> getStudyGroupsAsync();

  Future<void> addStudyGroupAsync(StudyGroup studyGroup);
}

class StudyGroupsRepoImpl extends StudyGroupsRepo {
  //* Private Properties
  final ApiService _apiService = locator<ApiService>();

  //* Overridden Methods
  @override
  Future<void> addStudyGroupAsync(StudyGroup studyGroup) async {
    await _apiService.postAsync(
      Endpoints.createStudyGroup,
      body: _studyGroupToJson(studyGroup),
    );
  }

  @override
  Future<List<StudyGroup>> getStudyGroupsAsync() async {
    Response response = await _apiService.getAsync(Endpoints.getStudyGroups);
    return _studyGroupsFromJson(response.body);
  }

  //* Private Methods
  String _studyGroupToJson(StudyGroup data) => json.encode(data.toJson());

  List<StudyGroup> _studyGroupsFromJson(String str) {
    final jsonMap = json.decode(str);

    return List<StudyGroup>.from(jsonMap.map(StudyGroup.fromJson));
  }
}
