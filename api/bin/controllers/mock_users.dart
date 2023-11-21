import '../models/user.dart';

class MockUsersRepo {
  List<User> getMockUsers() {
    return mockUsers;
  }

  final List<User> mockUsers = [
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
      lastName: 'Brown',
      year: 1,
      pronouns: 'She/Her',
      admin: false,
    ),
    User(
      id: '4',
      firstName: 'Ronald',
      lastName: 'McDonald',
      year: 2,
      pronouns: 'He/Him',
      admin: false,
    ),
  ];
}
