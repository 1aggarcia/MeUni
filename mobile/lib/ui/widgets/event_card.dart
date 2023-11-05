import 'package:flutter/material.dart';

import '../../models/event.dart';

class EventCard extends StatelessWidget {
  //* Public Properties
  final Event event;

  //* Constructors
  const EventCard({super.key, required this.event});

  //* Overriden Methods
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
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
                    'Time: ${event.startTime} - ${event.endTime}',
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
                    'Where: ${event.location}',
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
