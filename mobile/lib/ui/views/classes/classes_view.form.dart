// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String ClassValueKey = 'class';

final Map<String, TextEditingController> _ClassesViewTextEditingControllers =
    {};

final Map<String, FocusNode> _ClassesViewFocusNodes = {};

final Map<String, String? Function(String?)?> _ClassesViewTextValidations = {
  ClassValueKey: null,
};

mixin $ClassesView {
  TextEditingController get classController =>
      _getFormTextEditingController(ClassValueKey);

  FocusNode get classFocusNode => _getFormFocusNode(ClassValueKey);

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
    classController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    classController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          ClassValueKey: classController.text,
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

  String? get classValue => this.formValueMap[ClassValueKey] as String?;

  set classValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ClassValueKey: value}),
    );

    if (_ClassesViewTextEditingControllers.containsKey(ClassValueKey)) {
      _ClassesViewTextEditingControllers[ClassValueKey]?.text = value ?? '';
    }
  }

  bool get hasClass =>
      this.formValueMap.containsKey(ClassValueKey) &&
      (classValue?.isNotEmpty ?? false);

  bool get hasClassValidationMessage =>
      this.fieldsValidationMessages[ClassValueKey]?.isNotEmpty ?? false;

  String? get classValidationMessage =>
      this.fieldsValidationMessages[ClassValueKey];
}

extension Methods on FormStateHelper {
  setClassValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ClassValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    classValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      ClassValueKey: getValidationMessage(ClassValueKey),
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
      ClassValueKey: getValidationMessage(ClassValueKey),
    });
