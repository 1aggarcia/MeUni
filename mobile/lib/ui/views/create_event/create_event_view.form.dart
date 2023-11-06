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

final Map<String, TextEditingController>
    _CreateEventViewTextEditingControllers = {};

final Map<String, FocusNode> _CreateEventViewFocusNodes = {};

final Map<String, String? Function(String?)?> _CreateEventViewTextValidations =
    {
  EventNameValueKey: CreateEventValidators.validateEventName,
};

mixin $CreateEventView {
  TextEditingController get eventNameController =>
      _getFormTextEditingController(EventNameValueKey);

  FocusNode get eventNameFocusNode => _getFormFocusNode(EventNameValueKey);

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

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          EventNameValueKey: eventNameController.text,
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

  set eventNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EventNameValueKey: value}),
    );

    if (_CreateEventViewTextEditingControllers.containsKey(EventNameValueKey)) {
      _CreateEventViewTextEditingControllers[EventNameValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasEventName =>
      this.formValueMap.containsKey(EventNameValueKey) &&
      (eventNameValue?.isNotEmpty ?? false);

  bool get hasEventNameValidationMessage =>
      this.fieldsValidationMessages[EventNameValueKey]?.isNotEmpty ?? false;

  String? get eventNameValidationMessage =>
      this.fieldsValidationMessages[EventNameValueKey];
}

extension Methods on FormStateHelper {
  setEventNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EventNameValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    eventNameValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      EventNameValueKey: getValidationMessage(EventNameValueKey),
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
    });
