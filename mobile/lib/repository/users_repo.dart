import '../models/user.dart';

abstract class UsersRepo {
  //* Public Properties
  User? loggedInUser;

  //* Public Methods
  Future<User> addUserAsync({
    required String id,
    required String firstName,
    required String lastName,
    required int year,
    required String pronouns,
  });

  Future<User?> getUserAsync(String id);
}
