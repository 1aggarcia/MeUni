import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  TimeOfDay fromString(String time) {
    int hh = 0;
    if (time.endsWith('PM')) hh = 12;
    time = time.split(' ')[0];
    return TimeOfDay(
      hour: hh + int.parse(time.split(":")[0]) % 24, // in case of a bad time format entered manually by the user
      minute: int.parse(time.split(":")[1]) % 60,
    );
  }

  //* Public Methods
  Future addEventAsync() async {
    if (isFormValid && eventNameValue != null) {
      DateTime dateTime = DateTime.parse(eventDateValue!);
      TimeOfDay startTime = fromString(eventStartTimeValue!);
      TimeOfDay endTime = fromString(eventEndTimeValue!);


      Event event = Event(
          id: -1,
          title: eventNameValue ?? '',
          desc: eventDescriptionValue ?? '',
          location: eventLocationValue ?? '',
          max: -1,
          startTime: DateTime(dateTime.year, dateTime.month, dateTime.day,
              startTime.hour, startTime.minute),
          endTime: DateTime(dateTime.year, dateTime.month, dateTime.day,
              endTime.hour, endTime.minute),
          hostId: -1,
          hostName: "Ronals",
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

  static String? validateEventStartTime(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'Event Start Time Cannot be Empty';
    }

    return null;
  }

  static String? validateEventEndTime(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'Event End Time Cannot be Empty';
    }

    return null;
  }

  static String? validateEventDate(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'Event Date Cannot be Empty';
    }

    return null;
  }

}
