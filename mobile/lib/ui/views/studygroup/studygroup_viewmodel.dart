import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.router.dart';
import '../../../app/app.locator.dart';
import '../../../models/event.dart';
import '../../../models/studygroup.dart';
import '../../../repository/events_repo.dart';
import '../../../repository/studygroup_repo.dart';
import '../../../repository/users_repo.dart';

class StudyGroupViewModel extends BaseViewModel {
  //* Private Properties
  final _eventsRepo = locator<EventsRepo>();
  final _usersRepo = locator<UsersRepo>();
  final _studyGroupRepo = locator<StudyGroupRepo>();

  final _navigationService = locator<NavigationService>();

  //* Public Properties
  bool isLoading = false;

  String get userName => _usersRepo.loggedInUser!.firstName;

  List<Event> events = [];
  List<StudyGroup> studyGroups = [];

  //* Public Methods
  Future getStudyGroupsAsync() async {
    isLoading = true;
    rebuildUi();

    studyGroups = await _studyGroupRepo.getStudyGroupsAsync();

    isLoading = false;
    rebuildUi();
  }

  Future goToEventPageAsync() async =>
      await _navigationService.navigateToEventsView();

  Future goToCreateStudyGroupPageAsync() async =>
      await _navigationService.navigateToCreateStudyGroupView();

  Future logoutAsync() async => await _navigationService.replaceWithLoginView();
}
