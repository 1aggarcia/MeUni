import '../../app/app.dart';
import '../../models/user.dart';
import '../users_repo.dart';

class MockUsersRepo extends UsersRepo {
  //* Private Properties
  List<User> _users = [];
  final Map<String, List<String>> _userClasses = {};

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
        id: '3',
        firstName: 'Hannah',
        lastName: 'Something',
        year: 3,
        pronouns: 'She/Her',
        admin: false,
      ),
    ];
  }

  //* Public Properties
  @override
  Future<User?> addUserAsync({
    required String id,
    required String firstName,
    required String lastName,
    required int year,
    required String pronouns,
  }) async {
    await Future.delayed(App.demoDuration);

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
  Future<bool> addUserClassAsync({
    required String id,
    required String className,
  }) async {
    await Future.delayed(App.demoDuration);

    List<String>? classList = _userClasses[id];

    if (classList != null) {
      classList.add(className);
    } else {
      _userClasses[id] = [className];
    }

    return true;
  }

  @override
  Future<List<String>> getUserClassesAsync(String id) async {
    await Future.delayed(App.demoDuration);

    return _userClasses[id] ?? [];
  }

  @override
  Future<void> updateUserAsync(User user) async {
    await Future.delayed(App.demoDuration);

    for (int i = 0; i < _users.length; i++) {
      if (_users[i].id == user.id) {
        _users[i] = user;
      }
    }
  }
}
