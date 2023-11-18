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
    // TODO: implement addEventAsync
    _apiService.postAsync("/studygroup/create", studyGroupToJson(studyGroup));
  }

  @override
  Future<List<StudyGroup>> getStudyGroupsAsync() async {
    // TODO: implement getStudyGroupsAsync
    Response response = await _apiService.getAsync("/studygroup/get");
    return studyGroupsFromJson(response.body);
  }
}
