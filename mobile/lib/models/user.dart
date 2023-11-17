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
}
