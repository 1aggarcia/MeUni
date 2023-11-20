import 'dart:convert';
import 'dart:math';

import '../models/user.dart';

import 'package:firebase_dart/database.dart' as db;

abstract class UsersRepo {
  //* Public Methods

  // /// @returns the ID of the newly created user account
  // Future<int> createUserAsync(User user);

  // /// Replace the existing set of user information with
  // /// the given set of user information
  // /// @returns the updated set of uesr information
  // Future<List<String>?> updateUserAsync(String userId, String firstName, String lastName, String year, String pronouns);

  /// Returns the User if found, null otherwise
  Future<User?> getUserAsync(String id);
  
}

class UsersRepoImpl extends UsersRepo {
  // TODO : get database reference with locator (example in events_repo.dart)

  //* Overriden Methods
  // @override
  // Future<int> createUserAsync(User user) async {

  //   retur
  // }
  late db.DatabaseReference _userRef;

  @override
  Future<User?> getUserAsync(String id) async {
    final db.DataSnapshot snapshot = await _userRef.child(id).once();
    final json = jsonEncode(snapshot.value);
    return userFromJson(json);
  }

  // @override
  // Future<List<String>?> updateUserAsync(String userId, String firstName, String lastName, String year, String pronouns) {
  //   User? user = await getUserAsync(userID) as User;
  //   user.
  // }

  // /// Finds an available id in the database
  // /// @returns new id and its DatabaseReference
  // Future<(int, db.DatabaseReference)> getNewRefAsync() async {
  //   final rand = Random();
  //   int id = rand.nextInt(maxUsers);
  //   List<int> used = [id];
  //   db.DatabaseReference newRef = _usersRef.child("$id");
  //   db.DataSnapshot snapshot = await newRef.once();
  // }
}
