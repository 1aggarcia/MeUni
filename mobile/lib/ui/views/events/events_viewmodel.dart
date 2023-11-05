import 'package:meuni_mobile/app/app.locator.dart';
import 'package:meuni_mobile/app/app.router.dart';
import 'package:meuni_mobile/repository/events_repo.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/event.dart';

class EventsViewModel extends BaseViewModel {
  //* Private Properties
  final _eventsRepo = locator<EventsRepo>();

  final _navigationService = locator<NavigationService>();

  //* Public Properties
  bool isLoading = false;

  List<Event> events = [];

  //* Public Methods
  Future getEventsAsync() async {
    isLoading = true;
    rebuildUi();

    events = await _eventsRepo.getEventsAsync();
    isLoading = false;
    rebuildUi();
  }

  Future goToCreateEventPageAsync() async {
    await _navigationService.navigateToCreateEventView();
  }
}
