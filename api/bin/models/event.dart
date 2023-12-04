import 'dart:convert';

final int maxCapacity = 15; // maximum number of users that can join an event
final int maxStringLength = 333; // combined total of 999 characters max per event

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
  /// * requires json['title'] is String with length 1-333
  /// * requires json['desc'] is String with length 1-333
  /// * requires json['location'] is String with length 1-333
  /// * requires json['max'] is int within range 1-15
  /// * requires json['startTime'] is String formatted as ISO timestamp
  /// * requires json['endTime'] is String formatted as ISO timestamp
  /// * requires json['hostId'] is String
  /// * requires json['attendees'] is List<String> or null
  factory Event.fromJson(Map<String, dynamic> json) {
    // Check requirements part 1: check types for required params
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
    // part 2: check that params with limited ranges are within those ranges
    if (1 > json['max'] || json['max'] > maxCapacity) {
      throw Exception("param 'max' must be within range 1-$maxCapacity:\n$json");
    }
    if (json['title'].isEmpty || json['title'].length > maxStringLength) {
      throw Exception('Title is too long/short: len ${json['title'].length} chars');
    }
    if (json['desc'].isEmpty || json['desc'].length > maxStringLength) {
      throw Exception('Description is too long/short: ${json['desc'].length} chars');
    }
    if (json['location'].isEmpty || json['location'].length > maxStringLength) {
      throw Exception('Location is too long/short: ${json['location'].length} chars');
    }

    // part 3: check type of optional attendees param
    List<String> attendees = [];
    if (json['attendees'] is List<dynamic>) {
      attendees = List<String>.from(json['attendees']);
    } else if (json['attendees'] != null) {
      throw Exception(
          "Optional param 'attendees' must be of type List<String> if included:\n$json");
    }

    // all requirements met: create event
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
