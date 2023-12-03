// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:meuni_mobile/ui/views/classes/classes_viewmodel.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String PrefixValueKey = 'prefix';
const String CourseCodeValueKey = 'courseCode';

final Map<String, TextEditingController> _ClassesViewTextEditingControllers =
    {};

final Map<String, FocusNode> _ClassesViewFocusNodes = {};

final Map<String, String? Function(String?)?> _ClassesViewTextValidations = {
  PrefixValueKey: ClassValidators.validatePrefix,
  CourseCodeValueKey: ClassValidators.validateCourseCode,
};

mixin $ClassesView {
  TextEditingController get prefixController =>
      _getFormTextEditingController(PrefixValueKey);
  TextEditingController get courseCodeController =>
      _getFormTextEditingController(CourseCodeValueKey);

  FocusNode get prefixFocusNode => _getFormFocusNode(PrefixValueKey);
  FocusNode get courseCodeFocusNode => _getFormFocusNode(CourseCodeValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_ClassesViewTextEditingControllers.containsKey(key)) {
      return _ClassesViewTextEditingControllers[key]!;
    }

    _ClassesViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _ClassesViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_ClassesViewFocusNodes.containsKey(key)) {
      return _ClassesViewFocusNodes[key]!;
    }
    _ClassesViewFocusNodes[key] = FocusNode();
    return _ClassesViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    prefixController.addListener(() => _updateFormData(model));
    courseCodeController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    prefixController.addListener(() => _updateFormData(model));
    courseCodeController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          PrefixValueKey: prefixController.text,
          CourseCodeValueKey: courseCodeController.text,
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

    for (var controller in _ClassesViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _ClassesViewFocusNodes.values) {
      focusNode.dispose();
    }

    _ClassesViewTextEditingControllers.clear();
    _ClassesViewFocusNodes.clear();
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

  String? get prefixValue => this.formValueMap[PrefixValueKey] as String?;
  String? get courseCodeValue =>
      this.formValueMap[CourseCodeValueKey] as String?;

  set prefixValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PrefixValueKey: value}),
    );

    if (_ClassesViewTextEditingControllers.containsKey(PrefixValueKey)) {
      _ClassesViewTextEditingControllers[PrefixValueKey]?.text = value ?? '';
    }
  }

  set courseCodeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({CourseCodeValueKey: value}),
    );

    if (_ClassesViewTextEditingControllers.containsKey(CourseCodeValueKey)) {
      _ClassesViewTextEditingControllers[CourseCodeValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasPrefix =>
      this.formValueMap.containsKey(PrefixValueKey) &&
      (prefixValue?.isNotEmpty ?? false);
  bool get hasCourseCode =>
      this.formValueMap.containsKey(CourseCodeValueKey) &&
      (courseCodeValue?.isNotEmpty ?? false);

  bool get hasPrefixValidationMessage =>
      this.fieldsValidationMessages[PrefixValueKey]?.isNotEmpty ?? false;
  bool get hasCourseCodeValidationMessage =>
      this.fieldsValidationMessages[CourseCodeValueKey]?.isNotEmpty ?? false;

  String? get prefixValidationMessage =>
      this.fieldsValidationMessages[PrefixValueKey];
  String? get courseCodeValidationMessage =>
      this.fieldsValidationMessages[CourseCodeValueKey];
}

extension Methods on FormStateHelper {
  setPrefixValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PrefixValueKey] = validationMessage;
  setCourseCodeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CourseCodeValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    prefixValue = '';
    courseCodeValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      PrefixValueKey: getValidationMessage(PrefixValueKey),
      CourseCodeValueKey: getValidationMessage(CourseCodeValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _ClassesViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _ClassesViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      PrefixValueKey: getValidationMessage(PrefixValueKey),
      CourseCodeValueKey: getValidationMessage(CourseCodeValueKey),
    });
