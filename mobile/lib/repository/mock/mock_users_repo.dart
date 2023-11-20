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
    ];
  }

  //* Public Properties
  @override
  Future<User> addUserAsync({
    required String id,
    required String firstName,
    required String lastName,
    required int year,
    required String pronouns,
  }) async {
    User user = User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      year: year,
      pronouns: pronouns,
      admin: false,
    );

    _users.add(user);

    return user;
  }

  @override
  Future<User?> getUserAsync(String id) async {
    await Future.delayed(App.demoDuration);

    try {
      return _users.singleWhere((u) => u.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<String>> getUserClasses(String id) async {
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
