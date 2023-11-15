import 'dart:convert';

Event eventFromJson(String str) {
  var decode = json.decode(str);
  return Event.fromJson(decode);
}

String eventToJson(Event data) => json.encode(data.toJson());

List<Event> eventsFromJson(String str) =>
    List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventsToJson(List<Event> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Event {
  //* Public Properties
  final int id;

  final String title;
  final String desc;
  final String location;

  final int max;

  final DateTime startTime;
  final DateTime endTime;

  final int hostId;
  final String hostName;
  final List<int> attendees;

  //* Constructors
  Event(
      {required this.id,
      required this.title,
      required this.desc,
      required this.location,
      required this.max,
      required this.startTime,
      required this.endTime,
      required this.hostId,
      required this.hostName,
      required this.attendees});

  factory Event.fromJson(Map<String, dynamic> json) {

    List<int> attendees = List<int>.from(json['attendees']);

    return Event(
        id: json['id'],
        title: json['title'],
        desc: json['desc'],
        location: json['location'],
        max: json['max'],
        startTime: DateTime.parse(json['startTime']),
        endTime: DateTime.parse(json['endTime']),
        hostId: json['hostId'],
        hostName: json['hostName'],
        attendees: attendees,
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'title': title,
    'desc': desc,
    'location' : location,
    'max' : max,
    'startTime' : startTime.toIso8601String(),
    'endTime' : endTime.toIso8601String(),
    'hostId' : hostId,
    'hostName' : hostName,
    'attendees' : attendees,
  };
}
