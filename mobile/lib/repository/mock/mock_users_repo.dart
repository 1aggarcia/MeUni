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
    await Future.delayed(App.demoDuration);

    return _users.singleWhere((u) => u.id == id);
  }

  @override
  Future<List<String>> getUserClasses(int id) async {
    return ["CSE 403", "CSE 332", "MUS 350"];
  }

  @override
  Future updateUserAsync(User user) async {
    for (int i = 0; i < _users.length; i++) {
      if (_users[i].id == user.id) {
        _users[i] = user;
      }
    }
  }
}
