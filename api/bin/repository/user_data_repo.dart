import 'package:firebase_dart/database.dart';

class UserDataRepo {
  //* Private Properties
  final DatabaseReference _reference;

  //* Constructors
  UserDataRepo(this._reference);

  /// Assigned given data to given user id
  /// @returns true iff userId is valid
  bool add(String userId, String data) {
    // TODO: implement add
    print(_reference); // prevent complaining for unused vars
    throw UnimplementedError();
  }

  /// Removes given data from given user id
  /// @returns true iff userId is valid
  bool remove(String userId, String data) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  /// Finds all data assigned to user with given id
  /// @returns list of data, or null if invalid user
  List<String>? getUserDataAsync(String userId) {
    // TODO: implement getUserDataAsync
    throw UnimplementedError();
  }
}
