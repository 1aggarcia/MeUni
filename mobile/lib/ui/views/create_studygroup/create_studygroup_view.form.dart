// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:meuni_mobile/ui/views/create_studygroup/create_studygroup_viewmodel.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String StudyGroupCourseValueKey = 'studyGroupCourse';
const String StudyGroupDescriptionValueKey = 'studyGroupDescription';
const String StudyGroupLocationValueKey = 'studyGroupLocation';
const String StudyGroupDateValueKey = 'studyGroupDate';
const String StudyGroupStartTimeValueKey = 'studyGroupStartTime';
const String StudyGroupEndTimeValueKey = 'studyGroupEndTime';

final Map<String, TextEditingController>
    _CreateStudyGroupViewTextEditingControllers = {};

final Map<String, FocusNode> _CreateStudyGroupViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _CreateStudyGroupViewTextValidations = {
  StudyGroupCourseValueKey: CreateStudyGroupValidators.validateStudyGroupCourse,
  StudyGroupDescriptionValueKey:
      CreateStudyGroupValidators.validateStudyGroupDescription,
  StudyGroupLocationValueKey:
      CreateStudyGroupValidators.validateStudyGroupLocation,
  StudyGroupDateValueKey: CreateStudyGroupValidators.validateStudyGroupDate,
  StudyGroupStartTimeValueKey:
      CreateStudyGroupValidators.validateStudyGroupStartTime,
  StudyGroupEndTimeValueKey:
      CreateStudyGroupValidators.validateStudyGroupEndTime,
};

mixin $CreateStudyGroupView {
  TextEditingController get studyGroupCourseController =>
      _getFormTextEditingController(StudyGroupCourseValueKey);
  TextEditingController get studyGroupDescriptionController =>
      _getFormTextEditingController(StudyGroupDescriptionValueKey);
  TextEditingController get studyGroupLocationController =>
      _getFormTextEditingController(StudyGroupLocationValueKey);
  TextEditingController get studyGroupDateController =>
      _getFormTextEditingController(StudyGroupDateValueKey);
  TextEditingController get studyGroupStartTimeController =>
      _getFormTextEditingController(StudyGroupStartTimeValueKey);
  TextEditingController get studyGroupEndTimeController =>
      _getFormTextEditingController(StudyGroupEndTimeValueKey);

  FocusNode get studyGroupCourseFocusNode =>
      _getFormFocusNode(StudyGroupCourseValueKey);
  FocusNode get studyGroupDescriptionFocusNode =>
      _getFormFocusNode(StudyGroupDescriptionValueKey);
  FocusNode get studyGroupLocationFocusNode =>
      _getFormFocusNode(StudyGroupLocationValueKey);
  FocusNode get studyGroupDateFocusNode =>
      _getFormFocusNode(StudyGroupDateValueKey);
  FocusNode get studyGroupStartTimeFocusNode =>
      _getFormFocusNode(StudyGroupStartTimeValueKey);
  FocusNode get studyGroupEndTimeFocusNode =>
      _getFormFocusNode(StudyGroupEndTimeValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_CreateStudyGroupViewTextEditingControllers.containsKey(key)) {
      return _CreateStudyGroupViewTextEditingControllers[key]!;
    }

    _CreateStudyGroupViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _CreateStudyGroupViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_CreateStudyGroupViewFocusNodes.containsKey(key)) {
      return _CreateStudyGroupViewFocusNodes[key]!;
    }
    _CreateStudyGroupViewFocusNodes[key] = FocusNode();
    return _CreateStudyGroupViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    studyGroupCourseController.addListener(() => _updateFormData(model));
    studyGroupDescriptionController.addListener(() => _updateFormData(model));
    studyGroupLocationController.addListener(() => _updateFormData(model));
    studyGroupDateController.addListener(() => _updateFormData(model));
    studyGroupStartTimeController.addListener(() => _updateFormData(model));
    studyGroupEndTimeController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    studyGroupCourseController.addListener(() => _updateFormData(model));
    studyGroupDescriptionController.addListener(() => _updateFormData(model));
    studyGroupLocationController.addListener(() => _updateFormData(model));
    studyGroupDateController.addListener(() => _updateFormData(model));
    studyGroupStartTimeController.addListener(() => _updateFormData(model));
    studyGroupEndTimeController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          StudyGroupCourseValueKey: studyGroupCourseController.text,
          StudyGroupDescriptionValueKey: studyGroupDescriptionController.text,
          StudyGroupLocationValueKey: studyGroupLocationController.text,
          StudyGroupDateValueKey: studyGroupDateController.text,
          StudyGroupStartTimeValueKey: studyGroupStartTimeController.text,
          StudyGroupEndTimeValueKey: studyGroupEndTimeController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _CreateStudyGroupViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _CreateStudyGroupViewFocusNodes.values) {
      focusNode.dispose();
    }

    _CreateStudyGroupViewTextEditingControllers.clear();
    _CreateStudyGroupViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get studyGroupCourseValue =>
      this.formValueMap[StudyGroupCourseValueKey] as String?;
  String? get studyGroupDescriptionValue =>
      this.formValueMap[StudyGroupDescriptionValueKey] as String?;
  String? get studyGroupLocationValue =>
      this.formValueMap[StudyGroupLocationValueKey] as String?;
  String? get studyGroupDateValue =>
      this.formValueMap[StudyGroupDateValueKey] as String?;
  String? get studyGroupStartTimeValue =>
      this.formValueMap[StudyGroupStartTimeValueKey] as String?;
  String? get studyGroupEndTimeValue =>
      this.formValueMap[StudyGroupEndTimeValueKey] as String?;

  set studyGroupCourseValue(String? value) {
    this.setData(
      this.formValueMap..addAll({StudyGroupCourseValueKey: value}),
    );

    if (_CreateStudyGroupViewTextEditingControllers.containsKey(
        StudyGroupCourseValueKey)) {
      _CreateStudyGroupViewTextEditingControllers[StudyGroupCourseValueKey]
          ?.text = value ?? '';
    }
  }

  set studyGroupDescriptionValue(String? value) {
    this.setData(
      this.formValueMap..addAll({StudyGroupDescriptionValueKey: value}),
    );

    if (_CreateStudyGroupViewTextEditingControllers.containsKey(
        StudyGroupDescriptionValueKey)) {
      _CreateStudyGroupViewTextEditingControllers[StudyGroupDescriptionValueKey]
          ?.text = value ?? '';
    }
  }

  set studyGroupLocationValue(String? value) {
    this.setData(
      this.formValueMap..addAll({StudyGroupLocationValueKey: value}),
    );

    if (_CreateStudyGroupViewTextEditingControllers.containsKey(
        StudyGroupLocationValueKey)) {
      _CreateStudyGroupViewTextEditingControllers[StudyGroupLocationValueKey]
          ?.text = value ?? '';
    }
  }

  set studyGroupDateValue(String? value) {
    this.setData(
      this.formValueMap..addAll({StudyGroupDateValueKey: value}),
    );

    if (_CreateStudyGroupViewTextEditingControllers.containsKey(
        StudyGroupDateValueKey)) {
      _CreateStudyGroupViewTextEditingControllers[StudyGroupDateValueKey]
          ?.text = value ?? '';
    }
  }

  set studyGroupStartTimeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({StudyGroupStartTimeValueKey: value}),
    );

    if (_CreateStudyGroupViewTextEditingControllers.containsKey(
        StudyGroupStartTimeValueKey)) {
      _CreateStudyGroupViewTextEditingControllers[StudyGroupStartTimeValueKey]
          ?.text = value ?? '';
    }
  }

  set studyGroupEndTimeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({StudyGroupEndTimeValueKey: value}),
    );

    if (_CreateStudyGroupViewTextEditingControllers.containsKey(
        StudyGroupEndTimeValueKey)) {
      _CreateStudyGroupViewTextEditingControllers[StudyGroupEndTimeValueKey]
          ?.text = value ?? '';
    }
  }

  bool get hasStudyGroupCourse =>
      this.formValueMap.containsKey(StudyGroupCourseValueKey) &&
      (studyGroupCourseValue?.isNotEmpty ?? false);
  bool get hasStudyGroupDescription =>
      this.formValueMap.containsKey(StudyGroupDescriptionValueKey) &&
      (studyGroupDescriptionValue?.isNotEmpty ?? false);
  bool get hasStudyGroupLocation =>
      this.formValueMap.containsKey(StudyGroupLocationValueKey) &&
      (studyGroupLocationValue?.isNotEmpty ?? false);
  bool get hasStudyGroupDate =>
      this.formValueMap.containsKey(StudyGroupDateValueKey) &&
      (studyGroupDateValue?.isNotEmpty ?? false);
  bool get hasStudyGroupStartTime =>
      this.formValueMap.containsKey(StudyGroupStartTimeValueKey) &&
      (studyGroupStartTimeValue?.isNotEmpty ?? false);
  bool get hasStudyGroupEndTime =>
      this.formValueMap.containsKey(StudyGroupEndTimeValueKey) &&
      (studyGroupEndTimeValue?.isNotEmpty ?? false);

  bool get hasStudyGroupCourseValidationMessage =>
      this.fieldsValidationMessages[StudyGroupCourseValueKey]?.isNotEmpty ??
      false;
  bool get hasStudyGroupDescriptionValidationMessage =>
      this
          .fieldsValidationMessages[StudyGroupDescriptionValueKey]
          ?.isNotEmpty ??
      false;
  bool get hasStudyGroupLocationValidationMessage =>
      this.fieldsValidationMessages[StudyGroupLocationValueKey]?.isNotEmpty ??
      false;
  bool get hasStudyGroupDateValidationMessage =>
      this.fieldsValidationMessages[StudyGroupDateValueKey]?.isNotEmpty ??
      false;
  bool get hasStudyGroupStartTimeValidationMessage =>
      this.fieldsValidationMessages[StudyGroupStartTimeValueKey]?.isNotEmpty ??
      false;
  bool get hasStudyGroupEndTimeValidationMessage =>
      this.fieldsValidationMessages[StudyGroupEndTimeValueKey]?.isNotEmpty ??
      false;

  String? get studyGroupCourseValidationMessage =>
      this.fieldsValidationMessages[StudyGroupCourseValueKey];
  String? get studyGroupDescriptionValidationMessage =>
      this.fieldsValidationMessages[StudyGroupDescriptionValueKey];
  String? get studyGroupLocationValidationMessage =>
      this.fieldsValidationMessages[StudyGroupLocationValueKey];
  String? get studyGroupDateValidationMessage =>
      this.fieldsValidationMessages[StudyGroupDateValueKey];
  String? get studyGroupStartTimeValidationMessage =>
      this.fieldsValidationMessages[StudyGroupStartTimeValueKey];
  String? get studyGroupEndTimeValidationMessage =>
      this.fieldsValidationMessages[StudyGroupEndTimeValueKey];
}

extension Methods on FormStateHelper {
  setStudyGroupCourseValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[StudyGroupCourseValueKey] =
          validationMessage;
  setStudyGroupDescriptionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[StudyGroupDescriptionValueKey] =
          validationMessage;
  setStudyGroupLocationValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[StudyGroupLocationValueKey] =
          validationMessage;
  setStudyGroupDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[StudyGroupDateValueKey] = validationMessage;
  setStudyGroupStartTimeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[StudyGroupStartTimeValueKey] =
          validationMessage;
  setStudyGroupEndTimeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[StudyGroupEndTimeValueKey] =
          validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    studyGroupCourseValue = '';
    studyGroupDescriptionValue = '';
    studyGroupLocationValue = '';
    studyGroupDateValue = '';
    studyGroupStartTimeValue = '';
    studyGroupEndTimeValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      StudyGroupCourseValueKey: getValidationMessage(StudyGroupCourseValueKey),
      StudyGroupDescriptionValueKey:
          getValidationMessage(StudyGroupDescriptionValueKey),
      StudyGroupLocationValueKey:
          getValidationMessage(StudyGroupLocationValueKey),
      StudyGroupDateValueKey: getValidationMessage(StudyGroupDateValueKey),
      StudyGroupStartTimeValueKey:
          getValidationMessage(StudyGroupStartTimeValueKey),
      StudyGroupEndTimeValueKey:
          getValidationMessage(StudyGroupEndTimeValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _CreateStudyGroupViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _CreateStudyGroupViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      StudyGroupCourseValueKey: getValidationMessage(StudyGroupCourseValueKey),
      StudyGroupDescriptionValueKey:
          getValidationMessage(StudyGroupDescriptionValueKey),
      StudyGroupLocationValueKey:
          getValidationMessage(StudyGroupLocationValueKey),
      StudyGroupDateValueKey: getValidationMessage(StudyGroupDateValueKey),
      StudyGroupStartTimeValueKey:
          getValidationMessage(StudyGroupStartTimeValueKey),
      StudyGroupEndTimeValueKey:
          getValidationMessage(StudyGroupEndTimeValueKey),
    });
