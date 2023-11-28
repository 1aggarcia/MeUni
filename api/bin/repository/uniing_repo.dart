import 'package:firebase_dart/database.dart';

import '../locator.dart';
import '../models/uniing.dart';

final String endpoint = 'uniing';

abstract class UniingRepo {
  //* Public Methods

  /// Returns the Uniing if found, null otherwise
  Future<Uniing?> getUniingAsync(String id);

  /// @returns the ID of the newly created uniing
  Future<String> addUniingAsync(Uniing uniing);

  /// Removes uniing of given id from database
  /// @returns id of deleted uniing
  Future<String> deleteUniingAsync(String id);
}

class UniingRepoImpl extends UniingRepo {
  //* Private Properties
  late DatabaseReference _uniingRef;

  //* Constructors
  UniingRepoImpl() {
    final dbRef = locator<DatabaseReference>();
    _uniingRef = dbRef.child(endpoint);
  }

  @override
  Future<Uniing?> getUniingAsync(String id) async {
    print(_uniingRef);
    throw UnimplementedError();
  }

  @override
  Future<String> addUniingAsync(Uniing uniing) async {
    throw UnimplementedError();
  }

  @override
  Future<String> deleteUniingAsync(String id) async {
    throw UnimplementedError();
  }
}
