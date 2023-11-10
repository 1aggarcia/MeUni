import 'package:test/test.dart';

import '../bin/controllers/user_controller.dart';
import '../bin/controllers/event_controller.dart';
import '../bin/models/user.dart';
import '../bin/models/event.dart';

void main() {
  userControllerTests();
}

void userControllerTests() {
  final UserController controller = UserController();
  final List<User> users = controller.getUsers();

  test('findUser', () {
    User fei = users[0];
    User testFei = controller.findUser(1);

    expect(testFei.id, fei.id);
    expect(testFei.firstName, fei.firstName);
    expect(testFei.lastName, fei.lastName);
    expect(testFei.year, fei.year);
    expect(testFei.pronouns, fei.pronouns);
    expect(testFei.admin, fei.admin);

    User john = users[1];
    User testJohn = controller.findUser(2);

    expect(testJohn.id, john.id);
    expect(testJohn.firstName, john.firstName);
    expect(testJohn.lastName, john.lastName);
    expect(testJohn.year, john.year);
    expect(testJohn.pronouns, john.pronouns);
    expect(testJohn.admin, john.admin);
  });

  test('findUser bad id', () {
    expect(controller.findUser(99), false);
    expect(controller.findUser(-50), false);
  });
}
