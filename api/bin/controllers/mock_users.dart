import '../models/user.dart';

class MockUsersRepo {

  List<User> getMockUsers() {
    return mockUsers;
  }

  final List<User> mockUsers = [
        User(
            firstName: 'Fei',
            lastName: 'Huang',
            year: 4,
            pronouns: 'He/Him',
            admin: true,
            id: 1),
        User(
            firstName: 'John',
            lastName: 'Stuart',
            year: 3,
            pronouns: 'He/Him',
            admin: false,
            id: 2)
      ];
}