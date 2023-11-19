import 'package:firebase_dart/database.dart';

/// Object to manage database a reference as a user table, assigning users to string data,
/// for example an event id or friend id
class UserData {
  //* Private Properties
  final DatabaseReference reference;
  final String varName;

  //* Constructors
  UserData(this.reference, this.varName);

  //* Public Methods

  /// Assigned given data to given user id
  /// @returns true if succesfull
  bool add(String userId, String data) {
    final pair = {
      "userId": userId,
      varName : data
    };
    final DatabaseReference newRef = reference.push();
    newRef.update(pair);
    return true;
  }

  /// Removes given data from given user id
  /// @returns true iff given data is removed
  Future<bool> removeAsync(String userId, String data) async {
    bool wasRemoved = false;
    final DataSnapshot snapshot = await reference.once();
    final dynamic value = snapshot.value;

    if (value is Map<String, dynamic>) {
      final pair = {
        "userId": userId,
        varName : data
      };
      value.forEach((k, v) {
        if (v is Map<String, dynamic> && v == pair) {
          reference.child(k).remove();
          wasRemoved = true;
        }
      });
    }
    return wasRemoved;
  }

  /// Removes all entries containing given user id
  /// @returns true if succesfull
  Future<bool> removeUserAsync(String userId) async {
    // TODO: implement removeUserAsync
    throw UnimplementedError();
  }

  /// Removes all entries containing given data
  /// @returns true if succesfull
  Future<bool> removeDataAsync(String data) async {
    // TODO: implement removeDataAsync
    throw UnimplementedError();
  }

  /// Finds all entries assigned to user with given id
  /// @returns list of entries
  Future<List<String>> getEntriesAsync(String userId) async {
    List<String> entries = [];
    final DataSnapshot snapshot = await reference.once();
    final dynamic value = snapshot.value;

    if (value is Map<String, dynamic>) {
      value.forEach((k, v) {
        if (v is Map<String, dynamic> &&
              v['userId'] == userId &&
              v[varName] is String) {
          entries.add(v[varName]);
        }
      });
    }
    return entries;
  }
}
