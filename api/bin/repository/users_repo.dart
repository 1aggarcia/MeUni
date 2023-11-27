import 'dart:convert';

import 'package:firebase_dart/database.dart' as db;

import '../models/user.dart';


abstract class UsersRepo {
  //* Public Methods

  /// Returns the User if found, null otherwise
  Future<User?> getUserAsync(String id);
}

class UsersRepoImpl extends UsersRepo {
  late db.DatabaseReference _userRef;

  @override
  Future<User?> getUserAsync(String id) async {
    final db.DataSnapshot snapshot = await _userRef.child(id).once();
    final json = jsonEncode(snapshot.value);
    return userFromJson(json);
  }
}
