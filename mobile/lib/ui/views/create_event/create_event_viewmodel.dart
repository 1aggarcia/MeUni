import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// ignore_for_file: directives_ordering
import './create_event_view.form.dart';
import '../../../app/app.locator.dart';
import '../../../models/event.dart';
import '../../../repository/events_repo.dart';

class CreateEventViewModel extends FormViewModel {
  //* Private Properties
  final _eventsRepo = locator<EventsRepo>();

  final _navService = locator<NavigationService>();

  //* Public Methods
  Future addEventAsync() async {
    if (isFormValid) {
      DateTime dateTime = DateTime.parse(eventDateValue!);
      TimeOfDay startTime = _fromString(eventStartTimeValue!);
      TimeOfDay endTime = _fromString(eventEndTimeValue!);

      Event event = Event(
        id: '-1',
        title: eventNameValue!,
        desc: eventDescriptionValue!,
        location: eventLocationValue!,
        max: 15,
        startTime: DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          startTime.hour,
          startTime.minute,
        ),
        endTime: DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          endTime.hour,
          endTime.minute,
        ),
        hostId: '-1',
        hostName: 'Ronals',
        attendees: [],
      );

      await runBusyFuture(_eventsRepo.addEventAsync(event));

      goToPrevPage();
    }
  }

  void goToPrevPage() => _navService.back();

  //* Private Methods
  TimeOfDay _fromString(String time) {
    int hh = 0;
    if (time.endsWith('PM')) hh = 12;

    time = time.split(' ')[0];

    return TimeOfDay(
      // in case of a bad time format entered manually by the user
      hour: hh + int.parse(time.split(':')[0]) % 24,
      minute: int.parse(time.split(':')[1]) % 60,
    );
  }
}

class CreateEventValidators {
  //* Public Methods
  static String? validateEventName(String? value) =>
      _validateNotEmpty(value, 'Event Name');

  static String? validateEventDescription(String? value) =>
      _validateNotEmpty(value, 'Event Description');

  static String? validateEventLocation(String? value) =>
      _validateNotEmpty(value, 'Event Location');

  static String? validateEventStartTime(String? value) =>
      _validateNotEmpty(value, 'Event Start Time');

  static String? validateEventEndTime(String? value) =>
      _validateNotEmpty(value, 'Event End Time');

  static String? validateEventDate(String? value) =>
      _validateNotEmpty(value, 'Event Date');

  //* Private Methods
  static String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return '$fieldName Cannot be Empty';
    }

    return null;
  }
}
