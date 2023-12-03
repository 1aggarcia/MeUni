import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/i_event.dart';
import '../../common/app_colors.dart';

class IEventCard extends StatelessWidget {
  //* Public Properties
  final IEvent iEvent;

  //* Constructors
  const IEventCard({super.key, required this.iEvent});

  //* Overridden Methods
  @override
  Widget build(BuildContext context) {
    final startDate = DateFormat.MMMEd().format(iEvent.startTime);
    final startTime = DateFormat.jm().format(iEvent.startTime);
    final endTime = DateFormat.jm().format(iEvent.endTime);

    return Container(
      decoration: ShapeDecoration(
        color: kcSecondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        children: [
          _cardLabel(iEvent.title),
          _cardLabel(iEvent.desc),
          _cardLabel('$startDate @ $startTime - $endTime'),
          _cardLabel(iEvent.location),
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
