import 'dart:convert';

class User {
  final String id;
  final String id;
  final String firstName;
  final String lastName;
  final int year;
  final String pronouns;
  final bool admin;

  User(
      {required this.id,
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
        json['year'] is! int ||
        json['pronouns'] is! String ||
        json['admin'] is! bool) {
        json['admin'] is! bool) {
      throw Exception(
          'json map passed in with incorrect or missing params for User:\n$json');
    }

    return User(
        id: json['id'],
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
    throw UnimplementedError();
  }
}

User? userFromJson(String str) {
  try {
    return User.fromJson(json.decode(str));
    return User.fromJson(json.decode(str));
  } catch (e) {
    print('ERROR: userFromJson() $e');
    print('ERROR: userFromJson() $e');
    return null;
  }
}

List<User> usersFromJson(String data) {
  throw UnimplementedError();
}

List<User> usersFromMap(Map<String, dynamic> data) {
  throw UnimplementedError();
}

String userToJson(User data) => json.encode(data.toJson());
