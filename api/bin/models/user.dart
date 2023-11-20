import 'dart:convert';

// User userFromJson(String str, int userId) {
//   var decode = json.decode(str);
//   return User.fromJson(decode, userId);
// }

String userToJson(User data) => json.encode(data.toJson());

User? userFromJson(String str) {
  try {
    return User.fromJsonMap(json.decode(str));
  } catch (e) {
    return null;
  }
}


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

  Map<String, User> fromJsonMap(Map<String, dynamic> data) {
    Map<String, User> users = {};
    data.forEach((k, v) {
      if (int.tryParse(k) != null) {
        try {
          User e = User.fromJson(v);
          users[k] = e;
        } catch (e) {
          print ("fromJsonMap: $e");
        }
      }
    });
    return users;
  }

  Map<String, dynamic> toJson() => {
        'id' : id,
        'firstName' : firstName,
        'lastName': lastName,
        'year': year,
        'pronouns' : pronouns,
        'admin' : admin,
      };
}
