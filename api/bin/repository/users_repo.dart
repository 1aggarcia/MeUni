import '../models/user.dart';

abstract class UsersRepo {
  //* Public Methods

  /// Returns the User if found, null otherwise
  Future<User?> getUserAsync(String id);
}

class UsersRepoImpl extends UsersRepo {
  // TODO : get database reference with locator (example in events_repo.dart)

  //* Overriden Methods
  @override
  Future<User?> getUserAsync(String id) {
    // TODO: implement getUserAsync
    throw UnimplementedError();
  }
}
