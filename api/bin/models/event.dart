import 'dart:convert';
import 'user.dart';
import '../controllers/mock_users.dart';

final List<User> mockUsers = MockUsersRepo().getMockUsers();

class Event {
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
  final List<String> attendeeNames;

  Event({
    required this.id,
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

  factory Event.fromJson(Map<String, dynamic> json) {
    String hostName = userNamefromId(json['hostId']);
    List<int> attendees = List<int>.from(json['attendees']);
    List<String> attendeeNames = [];
    for (int i in attendees) {
      attendeeNames.add(userNamefromId(i));
    }

    return Event(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      location: json['location'],
      max: json['max'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      hostId: json['hostId'],
      hostName: hostName,
      attendees: attendees,
      attendeeNames: attendeeNames,
    );
  }

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
        'attendees': attendees,
        'attendeeNames': attendeeNames
      };
}

Event eventFromJson(String str) {
  var decode = json.decode(str);
  return Event.fromJson(decode);
}

String eventToJson(Event data) => json.encode(data.toJson());

List<Event> eventsFromJson(String str) =>
    List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventsToJson(List<Event> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

/// Given id, returns first name of given user, if it exists
/// @param userId - of desired user
/// @returns first name of user with userId, or "[Not found]" if unavaliable
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
    return "[Not found]";
  }
}
