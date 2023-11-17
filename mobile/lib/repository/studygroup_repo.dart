import 'package:http/http.dart';

import '../app/app.locator.dart';
import '../models/studygroup.dart';
import '../services/api_service.dart';

abstract class StudyGroupRepo {
  //* Public Methods
  Future<List<StudyGroup>> getStudyGroupsAsync();

  Future addStudyGroupAsync(StudyGroup event);
}

class StudyGroupRepoImpl extends StudyGroupRepo {
  final ApiService _apiService = locator<ApiService>();
  @override
  Future addStudyGroupAsync(StudyGroup event) async {
    // TODO: implement addEventAsync
    _apiService.postAsync("/studygroup/create", studygroupToJson(event));
  }

  @override
  Future<List<StudyGroup>> getStudyGroupsAsync() async {
    // TODO: implement getStudyGroupsAsync
    Response response = await _apiService.getAsync("/studygroup/get");
    return studygroupsFromJson(response.body);
  }
}
