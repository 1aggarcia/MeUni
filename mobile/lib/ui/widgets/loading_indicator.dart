import 'package:flutter/material.dart';

import '../common/ui_helpers.dart';

class LoadingIndicator extends StatelessWidget {
  //* Public Properties
  final String loadingText;

  //* Constructors
  const LoadingIndicator({
    super.key,
    required this.loadingText,
  });

  //* Overridden Methods
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$loadingText...',
            style: const TextStyle(
              color: Color(0xFF685050),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpaceMedium,
          const CircularProgressIndicator(color: Color(0xFF685050)),
        ],
      ),
    );
  }
}
