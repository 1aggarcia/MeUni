import '../../models/user.dart';
import '../users_repo.dart';

class MockUsersRepo extends UsersRepo {
  //* Private Properties
  List<User> _users = [];

  //* Constructors
  MockUsersRepo() {
    _users = [
      User(
        id: '1a',
        firstName: 'Fei',
        lastName: 'Huang',
        year: 4,
        pronouns: 'He/Him',
        admin: true,
      ),
      User(
        id: '2a',
        firstName: 'John',
        lastName: 'Stuart',
        year: 3,
        pronouns: 'He/Him',
        admin: false,
      ),
      User(
        id: '3a',
        firstName: 'Hannah',
        lastName: 'Brown',
        year: 1,
        pronouns: 'She/Her',
        admin: false,
      ),
      User(
        id: '4a',
        firstName: 'Ronald',
        lastName: 'McDonald',
        year: 2,
        pronouns: 'He/Him',
        admin: false,
      )
    ];
  }

  //* Overriden Methods

  @override
  Future<User?> getUserAsync(String id) async {
    try {
      return _users.singleWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }
}
