// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String SearchEventValueKey = 'searchEvent';
const String SearchStudyGroupValueKey = 'searchStudyGroup';

final Map<String, TextEditingController> _IEventsViewTextEditingControllers =
    {};

final Map<String, FocusNode> _IEventsViewFocusNodes = {};

final Map<String, String? Function(String?)?> _IEventsViewTextValidations = {
  SearchEventValueKey: null,
  SearchStudyGroupValueKey: null,
};

mixin $IEventsView {
  TextEditingController get searchEventController =>
      _getFormTextEditingController(SearchEventValueKey);
  TextEditingController get searchStudyGroupController =>
      _getFormTextEditingController(SearchStudyGroupValueKey);

  FocusNode get searchEventFocusNode => _getFormFocusNode(SearchEventValueKey);
  FocusNode get searchStudyGroupFocusNode =>
      _getFormFocusNode(SearchStudyGroupValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_IEventsViewTextEditingControllers.containsKey(key)) {
      return _IEventsViewTextEditingControllers[key]!;
    }

    _IEventsViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _IEventsViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_IEventsViewFocusNodes.containsKey(key)) {
      return _IEventsViewFocusNodes[key]!;
    }
    _IEventsViewFocusNodes[key] = FocusNode();
    return _IEventsViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    searchEventController.addListener(() => _updateFormData(model));
    searchStudyGroupController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    searchEventController.addListener(() => _updateFormData(model));
    searchStudyGroupController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          SearchEventValueKey: searchEventController.text,
          SearchStudyGroupValueKey: searchStudyGroupController.text,
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

    for (var controller in _IEventsViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _IEventsViewFocusNodes.values) {
      focusNode.dispose();
    }

    _IEventsViewTextEditingControllers.clear();
    _IEventsViewFocusNodes.clear();
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

  String? get searchEventValue =>
      this.formValueMap[SearchEventValueKey] as String?;
  String? get searchStudyGroupValue =>
      this.formValueMap[SearchStudyGroupValueKey] as String?;

  set searchEventValue(String? value) {
    this.setData(
      this.formValueMap..addAll({SearchEventValueKey: value}),
    );

    if (_IEventsViewTextEditingControllers.containsKey(SearchEventValueKey)) {
      _IEventsViewTextEditingControllers[SearchEventValueKey]?.text =
          value ?? '';
    }
  }

  set searchStudyGroupValue(String? value) {
    this.setData(
      this.formValueMap..addAll({SearchStudyGroupValueKey: value}),
    );

    if (_IEventsViewTextEditingControllers.containsKey(
        SearchStudyGroupValueKey)) {
      _IEventsViewTextEditingControllers[SearchStudyGroupValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasSearchEvent =>
      this.formValueMap.containsKey(SearchEventValueKey) &&
      (searchEventValue?.isNotEmpty ?? false);
  bool get hasSearchStudyGroup =>
      this.formValueMap.containsKey(SearchStudyGroupValueKey) &&
      (searchStudyGroupValue?.isNotEmpty ?? false);

  bool get hasSearchEventValidationMessage =>
      this.fieldsValidationMessages[SearchEventValueKey]?.isNotEmpty ?? false;
  bool get hasSearchStudyGroupValidationMessage =>
      this.fieldsValidationMessages[SearchStudyGroupValueKey]?.isNotEmpty ??
      false;

  String? get searchEventValidationMessage =>
      this.fieldsValidationMessages[SearchEventValueKey];
  String? get searchStudyGroupValidationMessage =>
      this.fieldsValidationMessages[SearchStudyGroupValueKey];
}

extension Methods on FormStateHelper {
  setSearchEventValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[SearchEventValueKey] = validationMessage;
  setSearchStudyGroupValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[SearchStudyGroupValueKey] =
          validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    searchEventValue = '';
    searchStudyGroupValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      SearchEventValueKey: getValidationMessage(SearchEventValueKey),
      SearchStudyGroupValueKey: getValidationMessage(SearchStudyGroupValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _IEventsViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _IEventsViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      SearchEventValueKey: getValidationMessage(SearchEventValueKey),
      SearchStudyGroupValueKey: getValidationMessage(SearchStudyGroupValueKey),
    });
