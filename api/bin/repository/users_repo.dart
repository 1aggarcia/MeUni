import 'dart:convert';
import 'package:firebase_dart/database.dart' as db;

// import 'package:firebase_dart/firebase_dart.dart' as fdb;

import '../locator.dart';
import '../models/user.dart';

abstract class UsersRepo {
  //* Public Methods

  /// Returns the User if found, null otherwise
  Future<User?> getUserAsync(String id);

  Future<String> updateUserAsync(User user);

  addUserAsync(User user) {}
}

class UsersRepoImpl extends UsersRepo {
  late db.DatabaseReference _userRef;

  // Constructor
  UsersRepoImpl() {
    final dbRef = locator<db.DatabaseReference>();
    _userRef = dbRef.child('users');
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
  Future<String> addUserAsync(User user) async {
    final db.DatabaseReference newRef = _userRef.push();
    final Map<String, dynamic> userJson = user.toJson();

    userJson.remove('id');
    await newRef.set(userJson);

    return newRef.key as String;
  }

  @override
  Future<String> updateUserAsync(User user) async {
    throw UnimplementedError();
  }
}
