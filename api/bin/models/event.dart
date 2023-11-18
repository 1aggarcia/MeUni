import 'dart:convert';

import 'user.dart';
import '../controllers/mock_users.dart';

final List<User> mockUsers = MockUsersRepo().getMockUsers();
final int maxCapacity = 15;

class Event {
  final String title;
  final String desc;
  final String location;
  final int max;

  final DateTime startTime;
  final DateTime endTime;

  final String hostId;
  final String hostName;

  final List<String> attendees;
  final List<String> attendeeNames;

  Event({
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
  /// @requires json['title'] is String,
  /// @requires json['desc'] is String,
  /// @requires json['location'] is String,
  /// @requires json['max'] is int,
  /// @requires json['startTime'] is String formatted as ISO timestamp,
  /// @requires json['endTime'] is String formatted as ISO timestamp,
  /// @requires json['hostId'] is String,
  /// @requires json['attendees'] is List<String> if included
  factory Event.fromJson(Map<String, dynamic> json) {
    if (json['title'] is! String ||
          json['desc'] is! String ||
          json['location'] is! String ||
          json['max'] is! int ||
          json['startTime'] is! String ||
          json['endTime'] is! String ||
          json['hostId'] is! String) {
      throw Exception("json map passed in with incorrect or missing params for Event:\n$json");
    }
    if (1 > json['max'] || json['max'] > maxCapacity) {
      throw Exception("param 'max' must be within range 1-$maxCapacity:\n$json");
    }
    List<String> attendees = [];
    List<String> attendeeNames = [];

    String hostName = userNamefromId(json['hostId']);
    if (json['attendees'] is List<dynamic>) {
      attendees = List<String>.from(json['attendees']);
      attendeeNames = [];
      for (String id in attendees) {
        attendeeNames.add(userNamefromId(id));
      }
    } else if (json['attendees'] != null) {
      throw Exception("Optional param 'attendees' must be of type List<String> if included:\n$json");
    }

    return Event(
      title: json['title'],
      desc: json['desc'],
      location: json['location'],
      max: json['max'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      hostId: json['hostId'],
      hostName: hostName,
      attendees: attendees,
      attendeeNames: attendeeNames
    );
  }

  // TODO: create 2nd toJson for database, leave this for clients

  /// Returns a json map of Event instance
  Map<String, dynamic> toJson() => {
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

  /// Does not check equality of attendees or attendeeNames
  bool equals(Event other) {
    return 
        title == other.title &&
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
Event? eventFromJson(String str){
  try {
    return Event.fromJson(json.decode(str));
  } catch(e) {
    return null; 
  }
}

/// Returns json as string representing passed in Event
String eventToJson(Event data) => json.encode(data.toJson());

/// Returns Map of all events provided in json string.
/// Improperly formatted entires ignored
Map<int, Event> eventsFromJson(String str) {
  try {
    return fromJsonMap(json.decode(str));
  } catch (e) {
    return {};
  }
}

/// Returns json as string representing passed in Map of events
String eventsToJson(Map<int, Event> data) => json.encode(toJsonMap(data));

/// Converts map of events to json map
Map<String, dynamic> toJsonMap(Map<int, Event> data) {
  return Map<String, dynamic>.fromEntries(
    data.entries.map((entry) => MapEntry(entry.key.toString(), entry.value.toJson())),
  );
}

/// Converts json map to map of events.
/// Improperly formatted entries ignored.
Map<int, Event> fromJsonMap(Map<String, dynamic> data) {
  Map<int, Event> events = {};
  data.forEach((k, v) {
    if (int.tryParse(k) != null) {
      try {
        Event e = Event.fromJson(v);
        events[int.parse(k)] = e;
      } catch (e) {
        print("fromJsonMap: $e");
      }
    }
  });
  return events;
}

/// Given id, returns first name of given user, if it exists
/// @param userId - of desired user
/// @returns first name of user with userId, or "[unknown user]" if unavaliable
String userNamefromId(String userId) {
  int i = 0;
  User u = mockUsers[i];
  // mockUsers will be exausted or desired user found
  while (i < mockUsers.length && u.id != userId) {
    u = mockUsers[i];
    i++;
  }

  if (u.id == userId) {
    return u.firstName;
  } else {
    return "[unknown user]";
  }
}

