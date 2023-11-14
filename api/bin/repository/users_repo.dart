import '../models/user.dart';

abstract class UsersRepo {
  //* Public Methods

  /// Returns the User if found, null otherwise
  Future<User?> getUserAsync(int id);
}

class UsersRepoImpl extends UsersRepo {
  //* Overriden Methods
  @override
  Future<User?> getUserAsync(int id) {
    // TODO: implement getUserAsync
    throw UnimplementedError();
  }
}
