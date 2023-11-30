import 'dart:convert';

final int maxYear = 4;

class User {
  final String id;
  final String firstName;
  final String lastName;
  final int year;
  final String pronouns;
  final bool admin;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.year,
      required this.pronouns,
      required this.admin});

  /// Creates an instance user from a json map.
  /// * requires json['id'] is String
  /// * requires json['firstName'] is String
  /// * requires json['lastName'] is String
  /// * requires json['year'] is int within range 1-4
  /// * requires json['pronouns'] is String
  /// * requires json['admin'] is bool
  factory User.fromJson(Map<String, dynamic> json) {
    if (json['id'] is! String ||
        json['firstName'] is! String ||
        json['lastName'] is! String ||
        json['year'] is! int ||
        json['pronouns'] is! String ||
        json['admin'] is! bool) {
      throw Exception(
          'json map passed in with incorrect or missing params for User:\n$json');

    }

    if (1 > json['year'] || json['year'] > maxYear) {
      throw Exception('Year must be between 1-4:');
    }

    return User(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        year: json['year'],
        pronouns: json['pronouns'],
        admin: json['admin']);
  }

  /// Returns a json map of User instance
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'year': year,
        'pronouns': pronouns,
        'admin': admin,
      };

  bool equals(User other) {
    return
      firstName == other.firstName &&
      lastName == other.lastName &&
      year == other.year &&
      pronouns == other.pronouns &&
      admin == other.admin;
  }
}

String userToJson(User data) => json.encode(data.toJson());

User? userFromJson(String str) {
  try {
    return User.fromJson(json.decode(str));
  } catch (e) {
    print('ERROR: userFromJson() $e');
    return null;
  }
}

/// Returns json string representing passed in User list
String usersToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

/// Converts json string to user list, improperly formatted entires ignored
List<User> usersFromJson(String str) {
  try {
    return usersFromMap(json.decode(str));
  } catch (e) {
    print('ERROR: usersFromJson() $e');
    return [];
  }
}

/// Converts json map to user list, improperly formatted entries ignored.
List<User> usersFromMap(Map<String, dynamic> data) {
  List<User> users = [];
  data.forEach((k, v) {
    try {
      User u = User.fromJson(v);
      users.add(u);
    } catch (e) {
      print('ERROR: eventsFromMap() $e');
    }
  });
  return users;
}