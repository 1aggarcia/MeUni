import 'i_event.dart';

class StudyGroup extends IEvent {
  //* Private Properties
  final String _course;

  //* Public Properties
  @override
  String get title => _course;

  //* Constructors
  StudyGroup({
    required super.id,
    required String course,
    required super.desc,
    required super.location,
    required super.max,
    required super.startTime,
    required super.endTime,
    required super.hostId,
    required super.hostName,
    required super.attendees,
  }) : _course = course;

  StudyGroup.fromJson(super.json)
      : _course = json['title'],
        super.fromJson();

  //* Overridden Methods
  @override
  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map['title'] = _course;

    return map;
  }
}
