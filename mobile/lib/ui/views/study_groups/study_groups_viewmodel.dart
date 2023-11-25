import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/event.dart';
import '../../../models/study_group.dart';
import '../../../repository/i_events_repo.dart';
import '../../../services/auth_service.dart';

class StudyGroupsViewModel extends BaseViewModel {
  //* Private Properties
  final _studyGroupsRepo = locator<IEventsRepo<StudyGroup>>();

  final _authService = locator<AuthService>();
  final _navService = locator<NavigationService>();

  //* Public Properties
  bool isLoading = false;

  String get userName => _authService.currUser.firstName;

  List<Event> events = [];
  List<StudyGroup> studyGroups = [];

  //* Public Methods
  Future getStudyGroupsAsync() async {
    isLoading = true;
    rebuildUi();

    studyGroups = await _studyGroupsRepo.getIEventsAsync() as List<StudyGroup>;

    isLoading = false;
    rebuildUi();
  }

  Future goToCreateStudyGroupPageAsync() async =>
      await _navService.navigateToCreateStudyGroupView();

  Future logoutAsync() async => await _navService.replaceWithLoginView();
}
