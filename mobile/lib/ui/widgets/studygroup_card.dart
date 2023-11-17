import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meuni_mobile/models/studygroup.dart';

import '../../models/event.dart';
import '../common/ui_helpers.dart';

class StudyGroupCard extends StatelessWidget {
  //* Public Properties
  final StudyGroup studyGroup;

  //* Constructors
  const StudyGroupCard({super.key, required this.studyGroup});

  //* Overriden Methods
  @override
  Widget build(BuildContext context) {
    final startDate = DateFormat.MMMEd().format(studyGroup.startTime);
    final startTime = DateFormat.jm().format(studyGroup.startTime);
    final endTime = DateFormat.jm().format(studyGroup.endTime);

    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontFamily: 'Hind Siliguri',
      fontWeight: FontWeight.w600,
      letterSpacing: 0.07,
    );

    return Column(
      children: [
        verticalSpaceLarge,
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
                    'Course: ${studyGroup.course}',
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  child: Text(
                    'Description: ${studyGroup.desc}',
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
                    'Location: ${studyGroup.location}',
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                ),
              ),
            ]))
      ],
    );
  }
}
