import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.all(20),
        backgroundColor: const Color(0xFF00004D),
        disabledBackgroundColor: const Color(0xFF00004D).withAlpha(120),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
