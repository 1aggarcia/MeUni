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

    const textStyle = TextStyle(
      color: kcTextPrimaryColor,
      fontSize: 15,
      fontFamily: 'Hind Siliguri',
      fontWeight: FontWeight.w600,
      letterSpacing: 0.07,
    );

    return Container(
      decoration: ShapeDecoration(
        color: kcSecondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              child: Text(
                'Title: ${event.title}',
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              child: Text(
                'Description: ${event.desc}',
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              child: Text(
                'Time: $startDate @ $startTime - $endTime',
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              child: Text(
                'Location: ${event.location}',
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
