import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/event.dart';
import '../../../repository/events_repo.dart';


class EventDetailViewModel extends BaseViewModel {
  //* Private Properties
  final _navService = locator<NavigationService>();

  final _eventsRepo = locator<EventsRepo>();

  //* Public Properties
  final String eventId;

  Event? event;

  //* Constructors
  EventDetailViewModel(this.eventId);

  //* Public Methods
  void goBack() => _navService.back();

  Future<void> getEvents() async {
    event = (await runBusyFuture(_eventsRepo.getEventAsync(eventId)))!;
  }

  Future<void> joinEvent() async {
    await _eventsRepo.joinEventAsync(eventId);
  }
}
