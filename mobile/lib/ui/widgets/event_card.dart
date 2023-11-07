import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/event.dart';

class EventCard extends StatelessWidget {
  //* Public Properties
  final Event event;

  //* Constructors
  const EventCard({super.key, required this.event});

  //* Overriden Methods
  @override
  Widget build(BuildContext context) {

    String startDate = DateFormat.MMMEd().format(event.startTime);
    String startTime = DateFormat.jm().format(event.startTime);
    String endTime = DateFormat.jm().format(event.endTime);
    return Column(
      children: [
        const SizedBox(
          height: 60,
        ),
        Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Column(children: [
              Container(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  child: Text(
                    'Description: ${event.desc}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Hind Siliguri',
                      fontWeight: FontWeight.w600,
                      // height: 0.03,
                      letterSpacing: 0.07,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  child: Text(
                    'Time: $startDate @ $startTime - $endTime',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Hind Siliguri',
                      fontWeight: FontWeight.w600,
                      // height: 0.03,
                      letterSpacing: 0.07,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  child: Text(
                    'Location: ${event.location}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Hind Siliguri',
                      fontWeight: FontWeight.w600,
                      // height: 0.03,
                      letterSpacing: 0.07,
                    ),
                  ),
                ),
              ),
            ]))
      ],
    );
  }
}
