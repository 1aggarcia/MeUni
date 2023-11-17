import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/studygroup.dart';
import '../../../repository/studygroup_repo.dart';
import './create_studygroup_view.form.dart';


class CreateStudyGroupViewModel extends FormViewModel {
  //* Private Properties
  final _studyGroupRepo = locator<StudyGroupRepo>();

  final _navigationService = locator<NavigationService>();

  //* Public Properties
  bool isLoading = false;

  //* Public Methods
  Future addStudyGroupAsync() async {
    if (isFormValid) {
      DateTime dateTime = DateTime.parse(studyGroupDateValue!);
      TimeOfDay startTime = _fromString(studyGroupStartTimeValue!);
      TimeOfDay endTime = _fromString(studyGroupEndTimeValue!);

      StudyGroup studyGroup = StudyGroup(
          id: -1,
          course: studyGroupCourseValue!,
          desc: studyGroupDescriptionValue!,
          location: studyGroupLocationValue!,
          max: -1,
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
          hostId: -1,
          hostName: "Ronals",
          attendees: []);

      isLoading = true;
      rebuildUi();

      await _studyGroupRepo.addStudyGroupAsync(studyGroup);

      isLoading = false;
      goToPrevPage();
    }
  }

  void goToPrevPage() => _navigationService.back();

  //* Private Methods
  TimeOfDay _fromString(String time) {
    int hh = 0;
    if (time.endsWith('PM')) hh = 12;

    time = time.split(' ')[0];

    return TimeOfDay(
      // in case of a bad time format entered manually by the user
      hour: hh + int.parse(time.split(":")[0]) % 24,
      minute: int.parse(time.split(":")[1]) % 60,
    );
  }
}

class CreateStudyGroupValidators {
  //* Public Methods
  static String? validateStudyGroupCourse(String? value) =>
      _validateNotEmpty(value, 'StudyGroup Name');

  static String? validateStudyGroupDescription(String? value) =>
      _validateNotEmpty(value, 'StudyGroup Description');

  static String? validateStudyGroupLocation(String? value) =>
      _validateNotEmpty(value, 'StudyGroup Location');

  static String? validateStudyGroupStartTime(String? value) =>
      _validateNotEmpty(value, 'StudyGroup Start Time');

  static String? validateStudyGroupEndTime(String? value) =>
      _validateNotEmpty(value, 'StudyGroup End Time');

  static String? validateStudyGroupDate(String? value) =>
      _validateNotEmpty(value, 'StudyGroup Date');

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
