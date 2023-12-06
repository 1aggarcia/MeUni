// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:meuni_mobile/ui/widgets/i_event/create_i_event_view/create_i_event_view_model.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String IEventNameValueKey = 'iEventName';
const String IEventDescriptionValueKey = 'iEventDescription';
const String IEventLocationValueKey = 'iEventLocation';
const String IEventMaxValueKey = 'iEventMax';
const String IEventDateValueKey = 'iEventDate';
const String IEventStartTimeValueKey = 'iEventStartTime';
const String IEventEndTimeValueKey = 'iEventEndTime';

final Map<String, TextEditingController>
    _CreateIEventViewTextEditingControllers = {};

final Map<String, FocusNode> _CreateIEventViewFocusNodes = {};

final Map<String, String? Function(String?)?> _CreateIEventViewTextValidations =
    {
  IEventNameValueKey: CreateIEventValidators.validateName,
  IEventDescriptionValueKey: CreateIEventValidators.validateDescription,
  IEventLocationValueKey: CreateIEventValidators.validateLocation,
  IEventMaxValueKey: CreateIEventValidators.validateMax,
  IEventDateValueKey: CreateIEventValidators.validateDate,
  IEventStartTimeValueKey: CreateIEventValidators.validateStartTime,
  IEventEndTimeValueKey: CreateIEventValidators.validateEndTime,
};

mixin $CreateIEventView {
  TextEditingController get iEventNameController =>
      _getFormTextEditingController(IEventNameValueKey);
  TextEditingController get iEventDescriptionController =>
      _getFormTextEditingController(IEventDescriptionValueKey);
  TextEditingController get iEventLocationController =>
      _getFormTextEditingController(IEventLocationValueKey);
  TextEditingController get iEventMaxController =>
      _getFormTextEditingController(IEventMaxValueKey);
  TextEditingController get iEventDateController =>
      _getFormTextEditingController(IEventDateValueKey);
  TextEditingController get iEventStartTimeController =>
      _getFormTextEditingController(IEventStartTimeValueKey);
  TextEditingController get iEventEndTimeController =>
      _getFormTextEditingController(IEventEndTimeValueKey);

  FocusNode get iEventNameFocusNode => _getFormFocusNode(IEventNameValueKey);
  FocusNode get iEventDescriptionFocusNode =>
      _getFormFocusNode(IEventDescriptionValueKey);
  FocusNode get iEventLocationFocusNode =>
      _getFormFocusNode(IEventLocationValueKey);
  FocusNode get iEventMaxFocusNode => _getFormFocusNode(IEventMaxValueKey);
  FocusNode get iEventDateFocusNode => _getFormFocusNode(IEventDateValueKey);
  FocusNode get iEventStartTimeFocusNode =>
      _getFormFocusNode(IEventStartTimeValueKey);
  FocusNode get iEventEndTimeFocusNode =>
      _getFormFocusNode(IEventEndTimeValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_CreateIEventViewTextEditingControllers.containsKey(key)) {
      return _CreateIEventViewTextEditingControllers[key]!;
    }

    _CreateIEventViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _CreateIEventViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_CreateIEventViewFocusNodes.containsKey(key)) {
      return _CreateIEventViewFocusNodes[key]!;
    }
    _CreateIEventViewFocusNodes[key] = FocusNode();
    return _CreateIEventViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    iEventNameController.addListener(() => _updateFormData(model));
    iEventDescriptionController.addListener(() => _updateFormData(model));
    iEventLocationController.addListener(() => _updateFormData(model));
    iEventMaxController.addListener(() => _updateFormData(model));
    iEventDateController.addListener(() => _updateFormData(model));
    iEventStartTimeController.addListener(() => _updateFormData(model));
    iEventEndTimeController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    iEventNameController.addListener(() => _updateFormData(model));
    iEventDescriptionController.addListener(() => _updateFormData(model));
    iEventLocationController.addListener(() => _updateFormData(model));
    iEventMaxController.addListener(() => _updateFormData(model));
    iEventDateController.addListener(() => _updateFormData(model));
    iEventStartTimeController.addListener(() => _updateFormData(model));
    iEventEndTimeController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          IEventNameValueKey: iEventNameController.text,
          IEventDescriptionValueKey: iEventDescriptionController.text,
          IEventLocationValueKey: iEventLocationController.text,
          IEventMaxValueKey: iEventMaxController.text,
          IEventDateValueKey: iEventDateController.text,
          IEventStartTimeValueKey: iEventStartTimeController.text,
          IEventEndTimeValueKey: iEventEndTimeController.text,
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

    for (var controller in _CreateIEventViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _CreateIEventViewFocusNodes.values) {
      focusNode.dispose();
    }

    _CreateIEventViewTextEditingControllers.clear();
    _CreateIEventViewFocusNodes.clear();
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

  String? get iEventNameValue =>
      this.formValueMap[IEventNameValueKey] as String?;
  String? get iEventDescriptionValue =>
      this.formValueMap[IEventDescriptionValueKey] as String?;
  String? get iEventLocationValue =>
      this.formValueMap[IEventLocationValueKey] as String?;
  String? get iEventMaxValue => this.formValueMap[IEventMaxValueKey] as String?;
  String? get iEventDateValue =>
      this.formValueMap[IEventDateValueKey] as String?;
  String? get iEventStartTimeValue =>
      this.formValueMap[IEventStartTimeValueKey] as String?;
  String? get iEventEndTimeValue =>
      this.formValueMap[IEventEndTimeValueKey] as String?;

  set iEventNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({IEventNameValueKey: value}),
    );

    if (_CreateIEventViewTextEditingControllers.containsKey(
        IEventNameValueKey)) {
      _CreateIEventViewTextEditingControllers[IEventNameValueKey]?.text =
          value ?? '';
    }
  }

  set iEventDescriptionValue(String? value) {
    this.setData(
      this.formValueMap..addAll({IEventDescriptionValueKey: value}),
    );

    if (_CreateIEventViewTextEditingControllers.containsKey(
        IEventDescriptionValueKey)) {
      _CreateIEventViewTextEditingControllers[IEventDescriptionValueKey]?.text =
          value ?? '';
    }
  }

  set iEventLocationValue(String? value) {
    this.setData(
      this.formValueMap..addAll({IEventLocationValueKey: value}),
    );

    if (_CreateIEventViewTextEditingControllers.containsKey(
        IEventLocationValueKey)) {
      _CreateIEventViewTextEditingControllers[IEventLocationValueKey]?.text =
          value ?? '';
    }
  }

  set iEventMaxValue(String? value) {
    this.setData(
      this.formValueMap..addAll({IEventMaxValueKey: value}),
    );

    if (_CreateIEventViewTextEditingControllers.containsKey(
        IEventMaxValueKey)) {
      _CreateIEventViewTextEditingControllers[IEventMaxValueKey]?.text =
          value ?? '';
    }
  }

  set iEventDateValue(String? value) {
    this.setData(
      this.formValueMap..addAll({IEventDateValueKey: value}),
    );

    if (_CreateIEventViewTextEditingControllers.containsKey(
        IEventDateValueKey)) {
      _CreateIEventViewTextEditingControllers[IEventDateValueKey]?.text =
          value ?? '';
    }
  }

  set iEventStartTimeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({IEventStartTimeValueKey: value}),
    );

    if (_CreateIEventViewTextEditingControllers.containsKey(
        IEventStartTimeValueKey)) {
      _CreateIEventViewTextEditingControllers[IEventStartTimeValueKey]?.text =
          value ?? '';
    }
  }

  set iEventEndTimeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({IEventEndTimeValueKey: value}),
    );

    if (_CreateIEventViewTextEditingControllers.containsKey(
        IEventEndTimeValueKey)) {
      _CreateIEventViewTextEditingControllers[IEventEndTimeValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasIEventName =>
      this.formValueMap.containsKey(IEventNameValueKey) &&
      (iEventNameValue?.isNotEmpty ?? false);
  bool get hasIEventDescription =>
      this.formValueMap.containsKey(IEventDescriptionValueKey) &&
      (iEventDescriptionValue?.isNotEmpty ?? false);
  bool get hasIEventLocation =>
      this.formValueMap.containsKey(IEventLocationValueKey) &&
      (iEventLocationValue?.isNotEmpty ?? false);
  bool get hasIEventMax =>
      this.formValueMap.containsKey(IEventMaxValueKey) &&
      (iEventMaxValue?.isNotEmpty ?? false);
  bool get hasIEventDate =>
      this.formValueMap.containsKey(IEventDateValueKey) &&
      (iEventDateValue?.isNotEmpty ?? false);
  bool get hasIEventStartTime =>
      this.formValueMap.containsKey(IEventStartTimeValueKey) &&
      (iEventStartTimeValue?.isNotEmpty ?? false);
  bool get hasIEventEndTime =>
      this.formValueMap.containsKey(IEventEndTimeValueKey) &&
      (iEventEndTimeValue?.isNotEmpty ?? false);

  bool get hasIEventNameValidationMessage =>
      this.fieldsValidationMessages[IEventNameValueKey]?.isNotEmpty ?? false;
  bool get hasIEventDescriptionValidationMessage =>
      this.fieldsValidationMessages[IEventDescriptionValueKey]?.isNotEmpty ??
      false;
  bool get hasIEventLocationValidationMessage =>
      this.fieldsValidationMessages[IEventLocationValueKey]?.isNotEmpty ??
      false;
  bool get hasIEventMaxValidationMessage =>
      this.fieldsValidationMessages[IEventMaxValueKey]?.isNotEmpty ?? false;
  bool get hasIEventDateValidationMessage =>
      this.fieldsValidationMessages[IEventDateValueKey]?.isNotEmpty ?? false;
  bool get hasIEventStartTimeValidationMessage =>
      this.fieldsValidationMessages[IEventStartTimeValueKey]?.isNotEmpty ??
      false;
  bool get hasIEventEndTimeValidationMessage =>
      this.fieldsValidationMessages[IEventEndTimeValueKey]?.isNotEmpty ?? false;

  String? get iEventNameValidationMessage =>
      this.fieldsValidationMessages[IEventNameValueKey];
  String? get iEventDescriptionValidationMessage =>
      this.fieldsValidationMessages[IEventDescriptionValueKey];
  String? get iEventLocationValidationMessage =>
      this.fieldsValidationMessages[IEventLocationValueKey];
  String? get iEventMaxValidationMessage =>
      this.fieldsValidationMessages[IEventMaxValueKey];
  String? get iEventDateValidationMessage =>
      this.fieldsValidationMessages[IEventDateValueKey];
  String? get iEventStartTimeValidationMessage =>
      this.fieldsValidationMessages[IEventStartTimeValueKey];
  String? get iEventEndTimeValidationMessage =>
      this.fieldsValidationMessages[IEventEndTimeValueKey];
}

extension Methods on FormStateHelper {
  setIEventNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[IEventNameValueKey] = validationMessage;
  setIEventDescriptionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[IEventDescriptionValueKey] =
          validationMessage;
  setIEventLocationValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[IEventLocationValueKey] = validationMessage;
  setIEventMaxValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[IEventMaxValueKey] = validationMessage;
  setIEventDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[IEventDateValueKey] = validationMessage;
  setIEventStartTimeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[IEventStartTimeValueKey] =
          validationMessage;
  setIEventEndTimeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[IEventEndTimeValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    iEventNameValue = '';
    iEventDescriptionValue = '';
    iEventLocationValue = '';
    iEventMaxValue = '';
    iEventDateValue = '';
    iEventStartTimeValue = '';
    iEventEndTimeValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      IEventNameValueKey: getValidationMessage(IEventNameValueKey),
      IEventDescriptionValueKey:
          getValidationMessage(IEventDescriptionValueKey),
      IEventLocationValueKey: getValidationMessage(IEventLocationValueKey),
      IEventMaxValueKey: getValidationMessage(IEventMaxValueKey),
      IEventDateValueKey: getValidationMessage(IEventDateValueKey),
      IEventStartTimeValueKey: getValidationMessage(IEventStartTimeValueKey),
      IEventEndTimeValueKey: getValidationMessage(IEventEndTimeValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _CreateIEventViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _CreateIEventViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      IEventNameValueKey: getValidationMessage(IEventNameValueKey),
      IEventDescriptionValueKey:
          getValidationMessage(IEventDescriptionValueKey),
      IEventLocationValueKey: getValidationMessage(IEventLocationValueKey),
      IEventMaxValueKey: getValidationMessage(IEventMaxValueKey),
      IEventDateValueKey: getValidationMessage(IEventDateValueKey),
      IEventStartTimeValueKey: getValidationMessage(IEventStartTimeValueKey),
      IEventEndTimeValueKey: getValidationMessage(IEventEndTimeValueKey),
    });
