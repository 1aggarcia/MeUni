import '../../models/user.dart';
import '../users_repo.dart';

class MockUsersRepo extends UsersRepo {
  //* Private Properties
  List<User> _users = [];

  //* Constructors
  MockUsersRepo() {
    _users = [
      User(
        firstName: 'Fei',
        lastName: 'Huang',
        year: 4,
        pronouns: 'He/Him',
        admin: true,
        id: 1,
      ),
      User(
        firstName: 'John',
        lastName: 'Stuart',
        year: 3,
        pronouns: 'He/Him',
        admin: false,
        id: 2,
      )
    ];
  }

  //* Public Properties
  @override
  Future<User> getUserAsync(int id) async {
    await Future.delayed(const Duration(seconds: 3));

    return _users.singleWhere((u) => u.id == id);
  }
}
