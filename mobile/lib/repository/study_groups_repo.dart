import 'package:http/http.dart';

import '../app/app.locator.dart';
import '../models/study_group.dart';
import '../services/api_service.dart';

abstract class StudyGroupsRepo {
  //* Public Methods
  Future<List<StudyGroup>> getStudyGroupsAsync();

  Future addStudyGroupAsync(StudyGroup studyGroup);
}

class StudyGroupsRepoImpl extends StudyGroupsRepo {
  final ApiService _apiService = locator<ApiService>();

  @override
  Future addStudyGroupAsync(StudyGroup studyGroup) async {
    await _apiService.postAsync(Endpoints.createStudyGroup,
        body: studyGroupToJson(studyGroup));
  }

  @override
  Future<List<StudyGroup>> getStudyGroupsAsync() async {
    Response response = await _apiService.getAsync(Endpoints.getStudyGroups);
    return studyGroupsFromJson(response.body);
  }
}
