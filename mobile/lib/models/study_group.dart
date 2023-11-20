import 'dart:convert';

StudyGroup studyGroupFromJson(String str) {
  var decode = json.decode(str);
  return StudyGroup.fromJson(decode);
}

String studyGroupToJson(StudyGroup data) => json.encode(data.toJson());

List<StudyGroup> studyGroupsFromJson(String str) =>
    List<StudyGroup>.from(json.decode(str).map((x) => StudyGroup.fromJson(x)));

String studyGroupsToJson(List<StudyGroup> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudyGroup {
  //* Public Properties
  final String id;

  final String course;
  final String desc;
  final String location;

  final int max;

  final DateTime startTime;
  final DateTime endTime;

  final int hostId;
  final String hostName;
  final List<String> attendees;

  //* Constructors
  StudyGroup({
    required this.id,
    required this.course,
    required this.desc,
    required this.location,
    required this.max,
    required this.startTime,
    required this.endTime,
    required this.hostId,
    required this.hostName,
    required this.attendees,
  });

  factory StudyGroup.fromJson(Map<String, dynamic> json) => StudyGroup(
        id: json['id'],
        course: json['course'],
        desc: json['desc'],
        location: json['location'],
        max: json['max'],
        startTime: DateTime.parse(json['startTime']),
        endTime: DateTime.parse(json['endTime']),
        hostId: json['hostId'],
        hostName: json['hostName'],
        attendees: List<String>.from(json['attendees']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'course': course,
        'desc': desc,
        'location': location,
        'max': max,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        'hostId': hostId,
        'hostName': hostName,
        'attendees': attendees,
      };
}
