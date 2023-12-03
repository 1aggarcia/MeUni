import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';

class MissingIndicator extends StatelessWidget {
  //* Public Properties
  final String label;

  //* Constructors
  const MissingIndicator({
    super.key,
    required this.label,
  });

  //* Overridden Methods
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 40,
          ),
          horizontalSpaceSmall,
          Text(
            label,
            style: const TextStyle(
              color: kcTextAccentColor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
