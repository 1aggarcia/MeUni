import 'package:flutter/material.dart';

import '../common/app_colors.dart';

class RoundButton extends StatelessWidget {
  //* Public Properties
  final String label;
  final VoidCallback? onPressed;

  //* Constructors
  const RoundButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  //* Overridden Methods
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15),
        backgroundColor: kcPrimaryColor,
        disabledBackgroundColor: kcPrimaryColor.withAlpha(120),
        foregroundColor: kcSecondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: kcSecondaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
