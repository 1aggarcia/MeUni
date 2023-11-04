import '../models/user.dart';

class MockUsersRepo {

  List<Event> getMockUsers() {
    return mockUsers;
  }

  final List<Event> mockUsers = [
        User(
            firstName: 'John',
            lastName: 'Doe',
            year: '2',
            pronouns: 'He/Him',
            admin: true,
            id: 1),
        User(
            firstName: 'John',
            lastName: 'Stuart',
            year: '3',
            pronouns: 'He/Him',
            admin: false,
            id: 2)
      ];
}