// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:meuni_mobile/ui/views/create_profile/create_profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String FirstNameValueKey = 'firstName';
const String LastNameValueKey = 'lastName';
const String YearValueKey = 'year';
const String PronounsValueKey = 'pronouns';

final Map<String, TextEditingController>
    _CreateProfileViewTextEditingControllers = {};

final Map<String, FocusNode> _CreateProfileViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _CreateProfileViewTextValidations = {
  FirstNameValueKey: null,
  LastNameValueKey: null,
  YearValueKey: CreateProfileValidators.validateYear,
  PronounsValueKey: null,
};

mixin $CreateProfileView {
  TextEditingController get firstNameController =>
      _getFormTextEditingController(FirstNameValueKey);
  TextEditingController get lastNameController =>
      _getFormTextEditingController(LastNameValueKey);
  TextEditingController get yearController =>
      _getFormTextEditingController(YearValueKey);
  TextEditingController get pronounsController =>
      _getFormTextEditingController(PronounsValueKey);

  FocusNode get firstNameFocusNode => _getFormFocusNode(FirstNameValueKey);
  FocusNode get lastNameFocusNode => _getFormFocusNode(LastNameValueKey);
  FocusNode get yearFocusNode => _getFormFocusNode(YearValueKey);
  FocusNode get pronounsFocusNode => _getFormFocusNode(PronounsValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_CreateProfileViewTextEditingControllers.containsKey(key)) {
      return _CreateProfileViewTextEditingControllers[key]!;
    }

    _CreateProfileViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _CreateProfileViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_CreateProfileViewFocusNodes.containsKey(key)) {
      return _CreateProfileViewFocusNodes[key]!;
    }
    _CreateProfileViewFocusNodes[key] = FocusNode();
    return _CreateProfileViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    firstNameController.addListener(() => _updateFormData(model));
    lastNameController.addListener(() => _updateFormData(model));
    yearController.addListener(() => _updateFormData(model));
    pronounsController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    firstNameController.addListener(() => _updateFormData(model));
    lastNameController.addListener(() => _updateFormData(model));
    yearController.addListener(() => _updateFormData(model));
    pronounsController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          FirstNameValueKey: firstNameController.text,
          LastNameValueKey: lastNameController.text,
          YearValueKey: yearController.text,
          PronounsValueKey: pronounsController.text,
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

    for (var controller in _CreateProfileViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _CreateProfileViewFocusNodes.values) {
      focusNode.dispose();
    }

    _CreateProfileViewTextEditingControllers.clear();
    _CreateProfileViewFocusNodes.clear();
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

  String? get firstNameValue => this.formValueMap[FirstNameValueKey] as String?;
  String? get lastNameValue => this.formValueMap[LastNameValueKey] as String?;
  String? get yearValue => this.formValueMap[YearValueKey] as String?;
  String? get pronounsValue => this.formValueMap[PronounsValueKey] as String?;

  set firstNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({FirstNameValueKey: value}),
    );

    if (_CreateProfileViewTextEditingControllers.containsKey(
        FirstNameValueKey)) {
      _CreateProfileViewTextEditingControllers[FirstNameValueKey]?.text =
          value ?? '';
    }
  }

  set lastNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({LastNameValueKey: value}),
    );

    if (_CreateProfileViewTextEditingControllers.containsKey(
        LastNameValueKey)) {
      _CreateProfileViewTextEditingControllers[LastNameValueKey]?.text =
          value ?? '';
    }
  }

  set yearValue(String? value) {
    this.setData(
      this.formValueMap..addAll({YearValueKey: value}),
    );

    if (_CreateProfileViewTextEditingControllers.containsKey(YearValueKey)) {
      _CreateProfileViewTextEditingControllers[YearValueKey]?.text =
          value ?? '';
    }
  }

  set pronounsValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PronounsValueKey: value}),
    );

    if (_CreateProfileViewTextEditingControllers.containsKey(
        PronounsValueKey)) {
      _CreateProfileViewTextEditingControllers[PronounsValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasFirstName =>
      this.formValueMap.containsKey(FirstNameValueKey) &&
      (firstNameValue?.isNotEmpty ?? false);
  bool get hasLastName =>
      this.formValueMap.containsKey(LastNameValueKey) &&
      (lastNameValue?.isNotEmpty ?? false);
  bool get hasYear =>
      this.formValueMap.containsKey(YearValueKey) &&
      (yearValue?.isNotEmpty ?? false);
  bool get hasPronouns =>
      this.formValueMap.containsKey(PronounsValueKey) &&
      (pronounsValue?.isNotEmpty ?? false);

  bool get hasFirstNameValidationMessage =>
      this.fieldsValidationMessages[FirstNameValueKey]?.isNotEmpty ?? false;
  bool get hasLastNameValidationMessage =>
      this.fieldsValidationMessages[LastNameValueKey]?.isNotEmpty ?? false;
  bool get hasYearValidationMessage =>
      this.fieldsValidationMessages[YearValueKey]?.isNotEmpty ?? false;
  bool get hasPronounsValidationMessage =>
      this.fieldsValidationMessages[PronounsValueKey]?.isNotEmpty ?? false;

  String? get firstNameValidationMessage =>
      this.fieldsValidationMessages[FirstNameValueKey];
  String? get lastNameValidationMessage =>
      this.fieldsValidationMessages[LastNameValueKey];
  String? get yearValidationMessage =>
      this.fieldsValidationMessages[YearValueKey];
  String? get pronounsValidationMessage =>
      this.fieldsValidationMessages[PronounsValueKey];
}

extension Methods on FormStateHelper {
  setFirstNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[FirstNameValueKey] = validationMessage;
  setLastNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[LastNameValueKey] = validationMessage;
  setYearValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[YearValueKey] = validationMessage;
  setPronounsValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PronounsValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    firstNameValue = '';
    lastNameValue = '';
    yearValue = '';
    pronounsValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      FirstNameValueKey: getValidationMessage(FirstNameValueKey),
      LastNameValueKey: getValidationMessage(LastNameValueKey),
      YearValueKey: getValidationMessage(YearValueKey),
      PronounsValueKey: getValidationMessage(PronounsValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _CreateProfileViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _CreateProfileViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      FirstNameValueKey: getValidationMessage(FirstNameValueKey),
      LastNameValueKey: getValidationMessage(LastNameValueKey),
      YearValueKey: getValidationMessage(YearValueKey),
      PronounsValueKey: getValidationMessage(PronounsValueKey),
    });
