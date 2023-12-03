import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../models/i_event.dart';
import '../../../../repository/i_events_repo.dart';
import 'create_i_event_view.form.dart';

class CreateIEventViewModel<T extends IEvent> extends FormViewModel {
  //* Private Properties
  final _iEventsRepo = locator<IEventsRepo<T>>();

  final _navService = locator<NavigationService>();

  //* Public Methods
  Future<void> addIEventAsync() async {
    if (isFormValid) {
      DateTime dateTime = DateTime.parse(iEventDateValue!);
      TimeOfDay startTime = _timeFromString(iEventStartTimeValue!);
      TimeOfDay endTime = _timeFromString(iEventEndTimeValue!);

      await runBusyFuture(
        _iEventsRepo.addIEventAsync(
          title: iEventNameValue!,
          desc: iEventDescriptionValue!,
          location: iEventLocationValue!,
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
        ),
      );

      _navService.back();
    }
  }

  //* Private Methods
  TimeOfDay _timeFromString(String time) {
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

class CreateIEventValidators {
  //* Public Methods
  static String? validateName(String? value) =>
      _validateNotEmpty(value, 'Name');

  static String? validateDescription(String? value) =>
      _validateNotEmpty(value, 'Description');

  static String? validateLocation(String? value) =>
      _validateNotEmpty(value, 'Location');

  static String? validateStartTime(String? value) =>
      _validateNotEmpty(value, 'Start Time');

  static String? validateEndTime(String? value) =>
      _validateNotEmpty(value, 'End Time');

  static String? validateDate(String? value) =>
      _validateNotEmpty(value, 'Date');

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
