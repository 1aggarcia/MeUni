import 'package:meuni_mobile/models/event.dart';
import 'package:meuni_mobile/ui/views/create_event/create_event_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../repository/events_repo.dart';

class CreateEventViewModel extends FormViewModel {
  //* Private Properties
  final _eventsRepo = locator<EventsRepo>();

  final _navigationService = locator<NavigationService>();

  //* Public Properties
  bool isLoading = false;

  //* Public Methods
  Future addEventAsync() async {
    if (isFormValid && eventNameValue != null) {
      Event event = Event(
          id: -1,
          title: eventNameValue ?? '',
          desc: eventDescriptionValue ?? '',
          location: eventLocationValue ?? '',
          max: -1,
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          hostId: -1,
          attendees: []);

      isLoading = true;
      rebuildUi();

      await _eventsRepo.addEventAsync(event);

      isLoading = false;
      goToPrevPage();
    }

  }

  void goToPrevPage() {
    _navigationService.back();
  }
}

class CreateEventValidators {
  static String? validateEventName(String? value) {
    if (value == null) {
      return null;
    }

    if (value.length > 20) {
      return 'Event Name too long';
    }

    return null;
  }

  static String? validateEventDescription(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'Event Description Cannot be Empty';
    }

    return null;
  }

  static String? validateEventLocation(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'Event Location Cannot be Empty';
    }

    return null;
  }
}
