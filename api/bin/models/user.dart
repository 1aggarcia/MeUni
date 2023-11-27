import 'dart:convert';

class User {
  String? id;
  final String firstName;
  final String lastName;
  final int year;
  final String pronouns;
  final bool admin;

  User(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.year,
      required this.pronouns,
      required this.admin});

  factory User.fromJson(Map<String, dynamic> json) {
    if (json['id'] is! String ||
        json['firstName'] is! String ||
        json['lastName'] is! String ||
        json['year'] is! String ||
        json['pronouns'] is! String ||
        json['admin'] is! String) {
      throw Exception(
          "json map passed in with incorrect or missing params for User:\n$json");
    }

    return User(
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
}

User? userFromJson(String str) {
  try {
    return userFromMap(json.decode(str));
  } catch (e) {
    print("ERROR: userFromJson() $e");
    return null;
  }
}

User? userFromMap(Map<String, dynamic> data) {}

String userToJson(User data) => json.encode(data.toJson());

String usersToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
