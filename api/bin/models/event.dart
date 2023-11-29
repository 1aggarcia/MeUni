import 'dart:convert';

final int maxCapacity = 15;

class Event {
  String? id;
  final String title;
  final String desc;
  final String location;
  final int max;

  final DateTime startTime;
  final DateTime endTime;

  final String hostId;
  String hostName;

  final List<String> attendees;
  List<String> attendeeNames;

  Event({
    this.id,
    required this.title,
    required this.desc,
    required this.location,
    required this.max,
    required this.startTime,
    required this.endTime,
    required this.hostId,
    required this.hostName,
    required this.attendees,
    required this.attendeeNames,
  });

  /// Creates an instance event from a json map.
  /// * requires json['title'] is String
  /// * requires json['desc'] is String
  /// * requires json['location'] is String
  /// * requires json['max'] is int
  /// * requires json['startTime'] is String formatted as ISO timestamp
  /// * requires json['endTime'] is String formatted as ISO timestamp
  /// * requires json['hostId'] is String
  /// * requires json['attendees'] is List<String> or null
  factory Event.fromJson(Map<String, dynamic> json) {
    if (json['title'] is! String ||
        json['desc'] is! String ||
        json['location'] is! String ||
        json['max'] is! int ||
        json['startTime'] is! String ||
        json['endTime'] is! String ||
        json['hostId'] is! String) {
      throw Exception(
          'json map passed in with incorrect or missing params for Event:\n$json');
    }
    if (1 > json['max'] || json['max'] > maxCapacity) {
      throw Exception(
          "param 'max' must be within range 1-$maxCapacity:\n$json");
    }
    List<String> attendees = [];

    if (json['attendees'] is List<dynamic>) {
      attendees = List<String>.from(json['attendees']);
    } else if (json['attendees'] != null) {
      throw Exception(
          "Optional param 'attendees' must be of type List<String> if included:\n$json");
    }

    return Event(
      title: json['title'],
      desc: json['desc'],
      location: json['location'],
      max: json['max'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      hostId: json['hostId'],
      hostName: '[unknown]',
      attendees: attendees,
      attendeeNames: []);
  }

  /// Returns a json map of Event instance
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'desc': desc,
    'location': location,
    'max': max,
    'startTime': startTime.toIso8601String(),
    'endTime': endTime.toIso8601String(),
    'hostId': hostId,
    'hostName': hostName,
  };

  /// Returns a json map of Event instance with all details except id
  Map<String, dynamic> toJsonFull() => {
    'id': id,
    'title': title,
    'desc': desc,
    'location': location,
    'max': max,
    'startTime': startTime.toIso8601String(),
    'endTime': endTime.toIso8601String(),
    'hostId': hostId,
    'hostName': hostName,
    'attendees': attendees,
    'attendeeNames': attendeeNames
  };

  /// Returns a copy of the instance event
  Event clone() {
    return Event(
      id: id,
      title: title,
      desc: desc,
      location: location,
      max: max,
      startTime: startTime,
      endTime: endTime,
      hostId: hostId,
      hostName: hostName,
      attendees: attendees,
      attendeeNames: attendeeNames,      
    );
  }

  /// Does not check equality of attendees, attendeeNames, or id
  bool equals(Event other) {
    return title == other.title &&
        desc == other.desc &&
        location == other.location &&
        max == other.max &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        hostId == other.hostId &&
        hostName == other.hostName;
  }
}

/// Given json string representing event, returns Event or null if improperly formatted
Event? eventFromJson(String str) {
  try {
    return Event.fromJson(json.decode(str));
  } catch (e) {
    print('ERROR: eventFromJson() $e');
    return null;
  }
}

/// Returns json string representing passed in Event
String eventToJson(Event data) => json.encode(data.toJsonFull());

/// Returns json string representing passed in Event list
String eventsToJson(List<Event> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

/// Converts json string to event list, improperly formatted entires ignored
List<Event> eventsFromJson(String str) {
  try {
    return eventsFromMap(json.decode(str));
  } catch (e) {
    print('ERROR: eventsFromJson() $e');
    return [];
  }
}

/// Converts json map to event list, improperly formatted entries ignored.
List<Event> eventsFromMap(Map<String, dynamic> data) {
  List<Event> events = [];
  data.forEach((k, v) {
    try {
      Event e = Event.fromJson(v);
      e.id = k;
      events.add(e);
    } catch (e) {
      print('ERROR: eventsFromMap() $e');
    }
  });
  return events;
}
