import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../../bin/controllers/user_controller.dart';
import '../../bin/locator.dart';
import '../../bin/repository/mock/mock_users_repo.dart';
import '../../bin/repository/users_repo.dart';

final String _rndUrl = 'https://example.com';

UserController _controller = UserController();

void main() {
  group('Users Controller -', () {
    setUp(() async {
      locator.reset();

      locator.registerLazySingleton<UsersRepo>(() => MockUsersRepo());

      _controller = UserController();
    });

    test('GET user profile', () async {
      Request req = Request(
        'GET',
        Uri.parse('$_rndUrl/profile/get?id=1'),
      );
      Response response = await _controller.getUserHandler(req);

      expect(response.statusCode, 200);
      expect(
          await response.readAsString(),
          '{"id":1,'
          '"firstName":"Fei",'
          '"lastName":"Huang",'
          '"year":4,'
          '"pronouns":"He/Him",'
          '"admin":true}');
    });
  });
}