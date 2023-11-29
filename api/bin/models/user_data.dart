import 'package:firebase_dart/database.dart';

/// Module to manage a database reference as a user table, assigning users to string data,
/// for example an event id or friend id
class UserData {
  //* Private Properties
  final DatabaseReference _reference;
  final String _varName;

  //* Constructors
  UserData(this._reference, this._varName);

  //* Public Methods

  /// Assigned given data to given user id
  /// @returns true if successful
  Future<bool> add(String userId, String data) async {
    final pair = {
      "userId": userId,
      _varName : data
    };
    final DatabaseReference newRef = _reference.push();
    await newRef.set(pair);
    return true;
  }

  /// Removes given data from given user id
  /// @returns true iff given data is removed
  Future<bool> remove(String userId, String data) async {
    bool wasRemoved = false;
    final DataSnapshot snapshot = await _reference.once();
    final dynamic value = snapshot.value;

    if (value is Map<String, dynamic>) {
      final pair = {
        "userId": userId,
        _varName : data
      };
      value.forEach((k, v) async {
        if (v is Map<String, dynamic> && v == pair) {
          // potential for multiple database calls
          await _reference.child(k).remove();
          wasRemoved = true;
        }
      });
    }
    return wasRemoved;
  }

  /// Removes all entries containing given user id
  /// @returns success
  Future<bool> removeUser(String userId) async {
    return _removeEveryInstance('userId', userId);
  }

  /// Removes all entries containing given data
  /// @returns success
  Future<bool> removeData(String data) async {
    return _removeEveryInstance(_varName, data);
  }

  /// Finds all entries assigned to user with given id
  /// @returns list of entries
  Future<List<String>> getEntries(String userId) async {
    List<String> entries = [];
    final DataSnapshot snapshot = await _reference.once();
    final dynamic value = snapshot.value;

    if (value is Map<String, dynamic>) {
      value.forEach((k, v) {
        if (v is Map<String, dynamic> &&
              v['userId'] == userId &&
              v[_varName] is String) {
          entries.add(v[_varName]);
        }
      });
    }
    return entries;
  }

  //* Helper methods

  /// Private helper, removes every instance of given param that matches given data
  /// @returns success
  Future<bool> _removeEveryInstance(String param, String data) async {
    final DataSnapshot snapshot = await _reference.once();
    final dynamic value = snapshot.value;

    if (value is Map<String, dynamic>) {
      value.removeWhere((k, v) => v[param] == data);
      await _reference.set(value);
      return true;
    } else {
      return false;
    }
  }
}