import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/event.dart';
import '../../../repository/events_repo.dart';

class EventDetailViewModel extends BaseViewModel {
  //* Private Properties
  final _dialogService = locator<DialogService>();
  final _navService = locator<NavigationService>();

  final _eventsRepo = locator<EventsRepo>();

  //* Public Properties
  final String eventId;

  late final Event event;

  //* Constructors
  EventDetailViewModel(this.eventId) {
    setBusy(true);
  }

  //* Public Methods
  void goBack() => _navService.back();

  Future<void> getEventAsync() async {
    var result = await _eventsRepo.getEventAsync(eventId);
    if (result == null) {
      await _dialogService.showDialog(
        title: 'Error!',
        description: 'Please try again another time.',
      );

      goBack();
    } else {
      event = result;

      setBusy(false);
    }
  }

  Future<void> joinEventAsync() async =>
      await _eventsRepo.joinEventAsync(eventId);
}
