import 'i_event.dart';

class StudyGroup extends IEvent {
  //* Public Properties
  final String course;

  //* Constructors
  StudyGroup({
    required super.id,
    required this.course,
    required super.desc,
    required super.location,
    required super.max,
    required super.startTime,
    required super.endTime,
    required super.hostId,
    required super.hostName,
    required super.attendees,
  });

  StudyGroup.fromJson(super.json)
      : course = json['course'],
        super.fromJson();

  //* Overridden Methods
  @override
  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map['course'] = course;

    return map;
  }
}
