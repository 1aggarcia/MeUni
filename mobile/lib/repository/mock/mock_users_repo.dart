import '../../app/app.dart';
import '../../models/user.dart';
import '../users_repo.dart';

class MockUsersRepo extends UsersRepo {
  //* Private Properties
  List<User> _users = [];

  //* Constructors
  MockUsersRepo() {
    _users = [
      User(
        id: '1',
        firstName: 'Fei',
        lastName: 'Huang',
        year: 4,
        pronouns: 'He/Him',
        admin: true,
      ),
      User(
        id: '2',
        firstName: 'John',
        lastName: 'Stuart',
        year: 3,
        pronouns: 'He/Him',
        admin: false,
      ),
      User(
        id: '4H1ZJTd7gUdQKSstwBG9DsKle0u2',
        firstName: 'Sandeep',
        lastName: 'Test',
        year: 3,
        pronouns: 'He/Him',
        admin: true,
      ),
    ];
  }

  //* Public Properties
  @override
  Future<User?> getUserAsync(String id) async {
    await Future.delayed(App.demoDuration);

    try {
      return _users.singleWhere((u) => u.id == id);
    } catch (e) {
      return null;
    }
  }
}
