import 'package:flutter/material.dart';

import '../../../models/event.dart';

void main() {
  runApp(FigmaToCodeApp());
}


class FigmaToCodeApp extends StatelessWidget {
  FigmaToCodeApp({super.key});
  final Event mockEvent = Event(
      id: 1,
      title: 'Pizza',
      desc: 'need ppl to chip in for pizza',
      location: 'The crib',
      max: 4,
      startTime: DateTime.parse('2023-11-04 03:04:15.537017Z'),
      endTime: DateTime.parse('2023-11-04 03:24:15.537017Z'),
      hostId: 1,
      attendees: [1, 2]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: Center(child: ListView(children: [
          EventCard(mockEvent),
        ]),)
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;
  EventCard(this.event);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 355.01,
          height: 146.02,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 344,
                  height: 76,
                  child: Text(
                    'Description: ' + event.desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Hind Siliguri',
                      fontWeight: FontWeight.w600,
                      height: 0.03,
                      letterSpacing: 0.07,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 344,
                  height: 76,
                  child: Text(
                    'Time: ' + event.startTime.toString() + ' - ' + event.endTime.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Hind Siliguri',
                      fontWeight: FontWeight.w600,
                      height: 0.03,
                      letterSpacing: 0.07,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 344,
                  height: 76,
                  child: Text(
                    'Where: ' + event.location,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Hind Siliguri',
                      fontWeight: FontWeight.w600,
                      height: 0.03,
                      letterSpacing: 0.07,
                    ),
                  ),
                ),
              ),
            ]
          )
        )
      ],
    );
  }
}
