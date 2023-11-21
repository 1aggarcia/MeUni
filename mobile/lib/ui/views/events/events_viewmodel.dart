import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/event.dart';
import '../../../repository/events_repo.dart';
import '../../../services/auth_service.dart';

class EventsViewModel extends BaseViewModel {
  //* Private Properties
  final _eventsRepo = locator<EventsRepo>();

  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  //* Public Properties
  String get userName => _authService.currUser.firstName;

  List<Event> events = [];

  //* Public Methods
  Future getEventsAsync() async {
    events = await runBusyFuture(
      _eventsRepo.getEventsAsync(),
      busyObject: events,
    );

    rebuildUi();
  }

  Future goToCreateEventPageAsync() async =>
      await _navigationService.navigateToCreateEventView();

  Future logoutAsync() async => await _navigationService.replaceWithLoginView();
}
