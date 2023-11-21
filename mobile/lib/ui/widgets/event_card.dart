import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/event.dart';
import '../common/app_colors.dart';

class EventCard extends StatelessWidget {
  //* Public Properties
  final Event event;

  //* Constructors
  const EventCard({super.key, required this.event});

  //* Overriden Methods
  @override
  Widget build(BuildContext context) {
    final startDate = DateFormat.MMMEd().format(event.startTime);
    final startTime = DateFormat.jm().format(event.startTime);
    final endTime = DateFormat.jm().format(event.endTime);

    return Container(
      decoration: ShapeDecoration(
        color: kcSecondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        children: [
          _cardLabel(event.title),
          _cardLabel(event.desc),
          _cardLabel('$startDate @ $startTime - $endTime'),
          _cardLabel(event.location),
        ],
      ),
    );
  }

  //* Private Methods
  Widget _cardLabel(String label) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: kcTextPrimaryColor,
            fontSize: 15,
            fontFamily: 'Hind Siliguri',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.07,
          ),
        ),
      ),
    );
  }
}
