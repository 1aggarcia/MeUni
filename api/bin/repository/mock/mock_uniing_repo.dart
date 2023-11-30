import '../../models/uniing.dart';
import '../uniing_repo.dart';

class MockUniingRepo extends UniingRepo {
  @override
  Future<Uniing?> getUniingAsync(String id) async {
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