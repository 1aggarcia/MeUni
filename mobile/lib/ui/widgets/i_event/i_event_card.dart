import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/i_event.dart';
import '../../common/app_colors.dart';

const double titleFontSize = 20;
const double textFontSize = 15;

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
          _cardLabel(iEvent.title, titleFontSize),
          _cardLabel(iEvent.desc, textFontSize),
          _cardLabel('$startDate, $startTime - $endTime', textFontSize),
          _cardLabel('@ ${iEvent.location}', textFontSize),
        ],
      ),
    );
  }

  //* Private Methods
  Widget _cardLabel(String label, double fontSize) {
    const cutOffPoint = 40;


    String cutLabel = label.length < cutOffPoint
        ? label
        : '${label.substring(0, cutOffPoint - 3)}...';

    return Container(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        child: Text(
          cutLabel,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kcTextPrimaryColor,
            fontSize: fontSize,
            fontFamily: 'Hind Siliguri',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.07,
          ),
        ),
      ),
    );
  }
}
