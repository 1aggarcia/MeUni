// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:meuni_mobile/ui/views/create_event/create_event_viewmodel.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String EventNameValueKey = 'eventName';
const String EventDescriptionValueKey = 'eventDescription';
const String EventLocationValueKey = 'eventLocation';
const String EventDateValueKey = 'eventDate';
const String EventStartTimeValueKey = 'eventStartTime';
const String EventEndTimeValueKey = 'eventEndTime';

final Map<String, TextEditingController>
    _CreateEventViewTextEditingControllers = {};

final Map<String, FocusNode> _CreateEventViewFocusNodes = {};

final Map<String, String? Function(String?)?> _CreateEventViewTextValidations =
    {
  EventNameValueKey: CreateEventValidators.validateEventName,
  EventDescriptionValueKey: CreateEventValidators.validateEventDescription,
  EventLocationValueKey: CreateEventValidators.validateEventLocation,
  EventDateValueKey: CreateEventValidators.validateEventDate,
  EventStartTimeValueKey: CreateEventValidators.validateEventStartTime,
  EventEndTimeValueKey: CreateEventValidators.validateEventEndTime,
};

mixin $CreateEventView {
  TextEditingController get eventNameController =>
      _getFormTextEditingController(EventNameValueKey);
  TextEditingController get eventDescriptionController =>
      _getFormTextEditingController(EventDescriptionValueKey);
  TextEditingController get eventLocationController =>
      _getFormTextEditingController(EventLocationValueKey);
  TextEditingController get eventDateController =>
      _getFormTextEditingController(EventDateValueKey);
  TextEditingController get eventStartTimeController =>
      _getFormTextEditingController(EventStartTimeValueKey);
  TextEditingController get eventEndTimeController =>
      _getFormTextEditingController(EventEndTimeValueKey);

  FocusNode get eventNameFocusNode => _getFormFocusNode(EventNameValueKey);
  FocusNode get eventDescriptionFocusNode =>
      _getFormFocusNode(EventDescriptionValueKey);
  FocusNode get eventLocationFocusNode =>
      _getFormFocusNode(EventLocationValueKey);
  FocusNode get eventDateFocusNode => _getFormFocusNode(EventDateValueKey);
  FocusNode get eventStartTimeFocusNode =>
      _getFormFocusNode(EventStartTimeValueKey);
  FocusNode get eventEndTimeFocusNode =>
      _getFormFocusNode(EventEndTimeValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_CreateEventViewTextEditingControllers.containsKey(key)) {
      return _CreateEventViewTextEditingControllers[key]!;
    }

    _CreateEventViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _CreateEventViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_CreateEventViewFocusNodes.containsKey(key)) {
      return _CreateEventViewFocusNodes[key]!;
    }
    _CreateEventViewFocusNodes[key] = FocusNode();
    return _CreateEventViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    eventNameController.addListener(() => _updateFormData(model));
    eventDescriptionController.addListener(() => _updateFormData(model));
    eventLocationController.addListener(() => _updateFormData(model));
    eventDateController.addListener(() => _updateFormData(model));
    eventStartTimeController.addListener(() => _updateFormData(model));
    eventEndTimeController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    eventNameController.addListener(() => _updateFormData(model));
    eventDescriptionController.addListener(() => _updateFormData(model));
    eventLocationController.addListener(() => _updateFormData(model));
    eventDateController.addListener(() => _updateFormData(model));
    eventStartTimeController.addListener(() => _updateFormData(model));
    eventEndTimeController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          EventNameValueKey: eventNameController.text,
          EventDescriptionValueKey: eventDescriptionController.text,
          EventLocationValueKey: eventLocationController.text,
          EventDateValueKey: eventDateController.text,
          EventStartTimeValueKey: eventStartTimeController.text,
          EventEndTimeValueKey: eventEndTimeController.text,
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

    for (var controller in _CreateEventViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _CreateEventViewFocusNodes.values) {
      focusNode.dispose();
    }

    _CreateEventViewTextEditingControllers.clear();
    _CreateEventViewFocusNodes.clear();
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

  String? get eventNameValue => this.formValueMap[EventNameValueKey] as String?;
  String? get eventDescriptionValue =>
      this.formValueMap[EventDescriptionValueKey] as String?;
  String? get eventLocationValue =>
      this.formValueMap[EventLocationValueKey] as String?;
  String? get eventDateValue => this.formValueMap[EventDateValueKey] as String?;
  String? get eventStartTimeValue =>
      this.formValueMap[EventStartTimeValueKey] as String?;
  String? get eventEndTimeValue =>
      this.formValueMap[EventEndTimeValueKey] as String?;

  set eventNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EventNameValueKey: value}),
    );

    if (_CreateEventViewTextEditingControllers.containsKey(EventNameValueKey)) {
      _CreateEventViewTextEditingControllers[EventNameValueKey]?.text =
          value ?? '';
    }
  }

  set eventDescriptionValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EventDescriptionValueKey: value}),
    );

    if (_CreateEventViewTextEditingControllers.containsKey(
        EventDescriptionValueKey)) {
      _CreateEventViewTextEditingControllers[EventDescriptionValueKey]?.text =
          value ?? '';
    }
  }

  set eventLocationValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EventLocationValueKey: value}),
    );

    if (_CreateEventViewTextEditingControllers.containsKey(
        EventLocationValueKey)) {
      _CreateEventViewTextEditingControllers[EventLocationValueKey]?.text =
          value ?? '';
    }
  }

  set eventDateValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EventDateValueKey: value}),
    );

    if (_CreateEventViewTextEditingControllers.containsKey(EventDateValueKey)) {
      _CreateEventViewTextEditingControllers[EventDateValueKey]?.text =
          value ?? '';
    }
  }

  set eventStartTimeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EventStartTimeValueKey: value}),
    );

    if (_CreateEventViewTextEditingControllers.containsKey(
        EventStartTimeValueKey)) {
      _CreateEventViewTextEditingControllers[EventStartTimeValueKey]?.text =
          value ?? '';
    }
  }

  set eventEndTimeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EventEndTimeValueKey: value}),
    );

    if (_CreateEventViewTextEditingControllers.containsKey(
        EventEndTimeValueKey)) {
      _CreateEventViewTextEditingControllers[EventEndTimeValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasEventName =>
      this.formValueMap.containsKey(EventNameValueKey) &&
      (eventNameValue?.isNotEmpty ?? false);
  bool get hasEventDescription =>
      this.formValueMap.containsKey(EventDescriptionValueKey) &&
      (eventDescriptionValue?.isNotEmpty ?? false);
  bool get hasEventLocation =>
      this.formValueMap.containsKey(EventLocationValueKey) &&
      (eventLocationValue?.isNotEmpty ?? false);
  bool get hasEventDate =>
      this.formValueMap.containsKey(EventDateValueKey) &&
      (eventDateValue?.isNotEmpty ?? false);
  bool get hasEventStartTime =>
      this.formValueMap.containsKey(EventStartTimeValueKey) &&
      (eventStartTimeValue?.isNotEmpty ?? false);
  bool get hasEventEndTime =>
      this.formValueMap.containsKey(EventEndTimeValueKey) &&
      (eventEndTimeValue?.isNotEmpty ?? false);

  bool get hasEventNameValidationMessage =>
      this.fieldsValidationMessages[EventNameValueKey]?.isNotEmpty ?? false;
  bool get hasEventDescriptionValidationMessage =>
      this.fieldsValidationMessages[EventDescriptionValueKey]?.isNotEmpty ??
      false;
  bool get hasEventLocationValidationMessage =>
      this.fieldsValidationMessages[EventLocationValueKey]?.isNotEmpty ?? false;
  bool get hasEventDateValidationMessage =>
      this.fieldsValidationMessages[EventDateValueKey]?.isNotEmpty ?? false;
  bool get hasEventStartTimeValidationMessage =>
      this.fieldsValidationMessages[EventStartTimeValueKey]?.isNotEmpty ??
      false;
  bool get hasEventEndTimeValidationMessage =>
      this.fieldsValidationMessages[EventEndTimeValueKey]?.isNotEmpty ?? false;

  String? get eventNameValidationMessage =>
      this.fieldsValidationMessages[EventNameValueKey];
  String? get eventDescriptionValidationMessage =>
      this.fieldsValidationMessages[EventDescriptionValueKey];
  String? get eventLocationValidationMessage =>
      this.fieldsValidationMessages[EventLocationValueKey];
  String? get eventDateValidationMessage =>
      this.fieldsValidationMessages[EventDateValueKey];
  String? get eventStartTimeValidationMessage =>
      this.fieldsValidationMessages[EventStartTimeValueKey];
  String? get eventEndTimeValidationMessage =>
      this.fieldsValidationMessages[EventEndTimeValueKey];
}

extension Methods on FormStateHelper {
  setEventNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EventNameValueKey] = validationMessage;
  setEventDescriptionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EventDescriptionValueKey] =
          validationMessage;
  setEventLocationValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EventLocationValueKey] = validationMessage;
  setEventDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EventDateValueKey] = validationMessage;
  setEventStartTimeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EventStartTimeValueKey] = validationMessage;
  setEventEndTimeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EventEndTimeValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    eventNameValue = '';
    eventDescriptionValue = '';
    eventLocationValue = '';
    eventDateValue = '';
    eventStartTimeValue = '';
    eventEndTimeValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      EventNameValueKey: getValidationMessage(EventNameValueKey),
      EventDescriptionValueKey: getValidationMessage(EventDescriptionValueKey),
      EventLocationValueKey: getValidationMessage(EventLocationValueKey),
      EventDateValueKey: getValidationMessage(EventDateValueKey),
      EventStartTimeValueKey: getValidationMessage(EventStartTimeValueKey),
      EventEndTimeValueKey: getValidationMessage(EventEndTimeValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _CreateEventViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _CreateEventViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      EventNameValueKey: getValidationMessage(EventNameValueKey),
      EventDescriptionValueKey: getValidationMessage(EventDescriptionValueKey),
      EventLocationValueKey: getValidationMessage(EventLocationValueKey),
      EventDateValueKey: getValidationMessage(EventDateValueKey),
      EventStartTimeValueKey: getValidationMessage(EventStartTimeValueKey),
      EventEndTimeValueKey: getValidationMessage(EventEndTimeValueKey),
    });
