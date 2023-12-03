import '../../models/user.dart';
import '../users_repo.dart';

class MockUsersRepo extends UsersRepo {
  List<User> users = [
      User(
        id: '0',
        firstName: 'Fei',
        lastName: 'Huang',
        year: 4,
        pronouns: 'He/Him',
        admin: true,
      ),
      User(
        id: '1',
        firstName: 'John',
        lastName: 'Stuart',
        year: 3,
        pronouns: 'He/Him',
        admin: false,
      ),
      User(
        id: '2',
        firstName: 'Hannah',
        lastName: 'Brown',
        year: 1,
        pronouns: 'She/Her',
        admin: false,
      ),
      User(
        id: '3',
        firstName: 'Ronald',
        lastName: 'McDonald',
        year: 2,
        pronouns: 'He/Him',
        admin: false,
      )
    ];

  //* Overriden Methods

  @override
  Future<User?> getUserAsync(String id) async {
    try {
      return users.singleWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<User>> getUsersAsync() async {
    return users;
  }

  @override
  Future<String> addUserAsync(User user) async {
    users.add(user);
    return user.id;
  }

  List<User> getMockUsers() {
    return users;
  }
}
