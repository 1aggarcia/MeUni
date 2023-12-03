import '../models/user.dart';

abstract class UsersRepo {
  //* Public Properties
  User? loggedInUser;

  //* Public Methods
  Future<User> getUserAsync(int id);
}
