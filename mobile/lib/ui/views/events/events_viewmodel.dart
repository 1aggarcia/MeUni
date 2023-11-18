import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.router.dart';
import '../../../app/app.locator.dart';
import '../../../models/event.dart';
import '../../../models/study_group.dart';
import '../../../repository/events_repo.dart';
import '../../../repository/users_repo.dart';

class EventsViewModel extends BaseViewModel {
  //* Private Properties
  final _eventsRepo = locator<EventsRepo>();
  final _usersRepo = locator<UsersRepo>();

  final _navigationService = locator<NavigationService>();

  //* Public Properties
  bool isLoading = false;

  String get userName => _usersRepo.loggedInUser!.firstName;

  List<Event> events = [];
  List<StudyGroup> studyGroups = [];

  //* Public Methods
  Future getEventsAsync() async {
    isLoading = true;
    rebuildUi();

    events = await _eventsRepo.getEventsAsync();

    isLoading = false;
    rebuildUi();
  }

  Future goToCreateEventPageAsync() async =>
      await _navigationService.navigateToCreateEventView();

  Future goToStudyGroupPageAsync() async =>
      await _navigationService.navigateToStudyGroupView();

  Future logoutAsync() async => await _navigationService.replaceWithLoginView();
}
