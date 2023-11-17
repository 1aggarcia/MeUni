import 'dart:convert';

import 'user.dart';
import '../controllers/mock_users.dart';

final List<User> mockUsers = MockUsersRepo().getMockUsers();

class Event {
  final String title;
  final String desc;
  final String location;
  final int max;

  final DateTime startTime;
  final DateTime endTime;

  final int hostId;
  final String hostName;

  final List<int> attendees;
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
  /// Required from json map:
  /// json['title'] is String,
  /// json['desc'] is String,
  /// json['location'] is String,
  /// json['max'] is int,
  /// json['startTime'] is String formatted as ISO date,
  /// json['endTime'] is String formatted as ISO date,
  /// json['hostId'] is int,
  /// json['attendees'] is List<int>
  factory Event.fromJson(Map<String, dynamic> json) {
    if (json['title'] is! String ||
          json['desc'] is! String ||
          json['location'] is! String ||
          json['max'] is! int ||
          json['startTime'] is! String ||
          json['endTime'] is! String ||
          json['hostId'] is! int ||
          json['attendees'] is! List<dynamic>) {
      throw Exception("json map passed in with incorrect types for Event:\n$json");
    }

    String hostName = userNamefromId(json['hostId']);
    List<int> attendees = List<int>.from(json['attendees']);
    List<String> attendeeNames = [];
    for (int i in attendees) {
      attendeeNames.add(userNamefromId(i));
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
Map<int, Event> eventsFromJson(String str) => fromJsonMap(json.decode(str));
    // Map<int, Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

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
        print("Failed to get event $k:");
        print("$e");
      }
    }
  });
  return events;
}

/// Given id, returns first name of given user, if it exists
/// @param userId - of desired user
/// @returns first name of user with userId, or "[unknown user]" if unavaliable
String userNamefromId(int userId) {
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
