import 'dart:convert';
import 'package:firebase_dart/database.dart' as db;
// import 'package:firebase_dart/firebase_dart.dart';

// import 'package:firebase_dart/firebase_dart.dart' as fdb;

import '../locator.dart';
import '../models/user.dart';
import '../models/user_data.dart';

abstract class UsersRepo {
  //* Public Methods

  /// Returns the User if found, null otherwise
  Future<User?> getUserAsync(String id);

  /// Returns list of all users
  Future<List<User>> getUsersAsync();

  /// Returns id of the newly created user
  Future<String> addUserAsync(User user);

  /// Returns list of courses
  Future<List<String>> getUserCoursesAsync(String id);

  Future<bool> addUserCoursesAsync(String userId, String course);

  Future<bool> removeUserCoursesAsync(String userId, String course);
}

class UsersRepoImpl extends UsersRepo {
  late db.DatabaseReference _userRef;
  late final UserData _userCoursesTable;
  late final db.DatabaseReference _courseRef;

  // Constructor
  UsersRepoImpl() {
    final dbRef = locator<db.DatabaseReference>();
    _userRef = dbRef.child('users');
    _courseRef = dbRef.child('user_courses');
    _userCoursesTable = UserData(_courseRef);
  }

  @override
  Future<User?> getUserAsync(String id) async {
    /// This is where the database is invoked.
    final db.DataSnapshot snapshot = await _userRef.child(id).once();

    /// Now, the user information is being encoded into Json
    final json = jsonEncode(snapshot.value);

    /// We ought to send back a User; so Json is being processed to User.
    return userFromJson(json);
  }

  @override
  Future<List<User>> getUsersAsync() async {
    final db.DataSnapshot snapshot = await _userRef.once();
    final json = jsonEncode(snapshot.value);

    return usersFromJson(json);
  }

  @override
  Future<String> addUserAsync(User user) async {
    final db.DatabaseReference newRef = _userRef.child(user.id);
    final Map<String, dynamic> userJson = user.toJson();
    await newRef.set(userJson);

    return newRef.key as String;
  }

  @override
  Future<List<String>> getUserCoursesAsync(String userId) async {
    return await _userCoursesTable.getEntries(userId);
  }

  @override
  Future<bool> addUserCoursesAsync(String userId, String course) async {
    return await _userCoursesTable.add(userId, course);
  }

  @override
  Future<bool> removeUserCoursesAsync(String userId, String course) async {
    return await _userCoursesTable.remove(userId, course);
  }
}
