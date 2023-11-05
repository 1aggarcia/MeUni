import 'package:meuni_mobile/models/event.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../repository/events_repo.dart';

class CreateEventViewModel extends BaseViewModel {
  //* Private Properties
  final _eventsRepo = locator<EventsRepo>();

  final _navigationService = locator<NavigationService>();

  //* Public Methods
  void addEventAsync(String eventName) async {
    Event event = Event(
        id: -1,
        title: eventName,
        desc: 'invalid',
        location: 'invalid',
        max: -1,
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        hostId: -1,
        attendees: []);

    await _eventsRepo.addEventAsync(event);
  }

  void goToPrevPage() {
    _navigationService.back();
  }
}
