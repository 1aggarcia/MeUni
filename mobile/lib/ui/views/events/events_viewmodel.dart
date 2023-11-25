import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/event.dart';
import '../../../repository/i_events_repo.dart';

class EventsViewModel extends BaseViewModel {
  //* Private Properties
  final _eventsRepo = locator<IEventsRepo<Event>>();

  final _navService = locator<NavigationService>();

  //* Public Properties
  List<Event> events = [];

  //* Public Methods
  Future<void> getEventsAsync() async {
    events = await runBusyFuture(
      _eventsRepo.getIEventsAsync(),
      busyObject: events,
    ) as List<Event>;
  }

  Future<void> goToCreateEventPageAsync() async =>
      await _navService.navigateToCreateEventView();

  Future<void> goToEventDetailPageAsync(int index) async =>
      await _navService.navigateToEventDetailView(eventId: events[index].id);
}
