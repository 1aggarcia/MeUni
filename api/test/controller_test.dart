import 'package:test/test.dart';

import '../bin/controllers/user_controller.dart';
import '../bin/controllers/event_controller.dart';
import '../bin/models/user.dart';
import '../bin/models/event.dart';

void main() {
  userControllerTests();
  eventControllerTests();
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

void eventControllerTests() {
  final EventController controller = EventController();
  final List<Event> events = controller.getEvents();

  test('findEvent', () {
    Event pizza = events[0];
    Event testPizza = controller.findEvent(-3);
    
    expect(pizza.id, testPizza.id);
    expect(pizza.title, testPizza.title);
    expect(pizza.desc, testPizza.desc);
    expect(pizza.location, testPizza.location);
    expect(pizza.max, testPizza.max);
    expect(pizza.startTime, testPizza.startTime);
    expect(pizza.endTime, testPizza.endTime);
    expect(pizza.hostId, testPizza.hostId);
    expect(pizza.attendees, testPizza.attendees);

    Event another = events[2];
    Event testAnother = controller.findEvent(-1);
    
    expect(another.id, testAnother.id);
    expect(another.title, testAnother.title);
    expect(another.desc, testAnother.desc);
    expect(another.location, testAnother.location);
    expect(another.max, testAnother.max);
    expect(another.startTime, testAnother.startTime);
    expect(another.endTime, testAnother.endTime);
    expect(another.hostId, testAnother.hostId);
    expect(another.attendees, testAnother.attendees);
  });

  test('findEvent bad id', () {
    expect(controller.findEvent(9), false);
    expect(controller.findEvent(-5), false);
  });
}