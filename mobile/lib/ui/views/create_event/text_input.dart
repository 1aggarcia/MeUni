import 'package:flutter/material.dart';

import '../../common/ui_helpers.dart';

class TextInput extends StatelessWidget {
  //* Private Properties
  final TextStyle? labelTextStyle;
  final TextStyle? errorTextStyle;

  final TextEditingController controller;

  final bool hasValidationMessage;
  final String? validationMessage;

  final String label;
  final String placeholder;

  const TextInput({
    super.key,
    required this.labelTextStyle,
    required this.errorTextStyle,
    required this.controller,
    required this.hasValidationMessage,
    required this.validationMessage,
    required this.label,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Event Name
        Text(
          label,
          style: labelTextStyle,
        ),
        verticalSpaceSmall,
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: placeholder,
          ),
        ),
        if (hasValidationMessage) ...[
          verticalSpaceTiny,
          Text(
            validationMessage!,
            style: errorTextStyle,
          ),
        ],
      ],
    );
  }
}
