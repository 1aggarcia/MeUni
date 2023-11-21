class User {
  //* Public Properties
  final String id;

  final String firstName;
  final String lastName;

  final int year;
  final String pronouns;

  final bool admin;

  //* Constructors
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.year,
    required this.pronouns,
    required this.admin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        year: json['year'],
        pronouns: json['pronouns'],
        admin: json['admin'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'year': year,
        'pronouns': pronouns,
        'admin': admin,
      };
}
