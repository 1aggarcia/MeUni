import 'dart:convert';

User userFromJson(String str, int userId) {
  var decode = json.decode(str);
  return User.fromJson(decode, userId);
}

String userToJson(User data) => json.encode(data.toJson());

List<User> usersFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x, -1)));

String usersToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.year,
    required this.pronouns,
    required this.admin
  });

  final String id;
  final String firstName;
  final String lastName;
  final int year;
  final String pronouns;
  final bool admin;

  factory User.fromJson(Map<String, dynamic> json, int userId) => User(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        year: json['year'],
        pronouns: json['pronouns'],
        admin: json['admin'],
      );

  Map<String, dynamic> toJson() => {
        'id' : id,
        'firstName' : firstName,
        'lastName': lastName,
        'year': year,
        'pronouns' : pronouns,
        'admin' : admin,
      };
}
