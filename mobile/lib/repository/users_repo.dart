import '../models/user.dart';

abstract class UsersRepo {
  //* Public Methods
  Future<User> getUserAsync(int id);
}
