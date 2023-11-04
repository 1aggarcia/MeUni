import 'dart:convert';

Event eventFromJson(String str, int eventId) {
  var decode = json.decode(str);
  return Event.fromJson(decode, eventId);
}

String eventToJson(Event data) => json.encode(data.toJson());

List<Event> eventsFromJson(String str) =>
    List<Event>.from(json.decode(str).map((x) => Event.fromJson(x, -1)));

String eventsToJson(List<Event> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
  Event({
    required this.id,
    required this.title,
    required this.desc,
    required this.location,
    required this.max,
    required this.startTime,
    required this.endTime,
    required this.hostId,
    required this.attendees
  });

  final int id;
  final String title;
  final String desc;
  final String location;
  final int max;
  final DateTime startTime;
  final DateTime endTime;
  final int hostId;
  final List<int> attendees;

  factory Event.fromJson(Map<String, dynamic> json, int eventId) => Event(
        id: eventId,
        title: json['title'],
        desc: json['desc'],
        location: json['location'],
        max: json['max'],
        startTime: DateTime.parse(json['startTime']),
        endTime: DateTime.parse(json['endTime']),
        hostId: json['hostId'],
        attendees: List<int>.from(json['attendees'])
      );

  Map<String, dynamic> toJson() => {
        'id' : id,
        'title': title,
        'desc': desc,
        'location' : location,
        'max' : max,
        'startTime' : startTime.toIso8601String(),
        'endTime' : endTime.toIso8601String(),
        'hostId' : hostId,
        'attendees' : attendees
      };
}
