import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../../bin/controllers/user_controller.dart';
import '../../bin/locator.dart';
import '../../bin/models/user.dart';
import '../../bin/repository/mock/mock_users_repo.dart';
import '../../bin/repository/users_repo.dart';

final String _rndUrl = 'https://example.com';

UserController _controller = UserController();
List<User> _mockUsers = MockUsersRepo().getMockUsers();

User anotherUser = User(
  id: '44',
  firstName: 'Another',
  lastName: 'User',
  year: 2,
  admin: false,
  pronouns: 'He/She'
);

void main() {
  group('Users Controller -', () {
    setUp(() async {
      await locator.reset();

      locator.registerLazySingleton<UsersRepo>(MockUsersRepo.new);
      
      _controller = UserController();
    });

    Future<Response> sendGetRequest(String args) async {
        Request req = Request(
          'GET',
          Uri.parse('$_rndUrl/user/profile/get$args'),
        );
        return await _controller.getUserHandler(req);
    }

    Future<Response> sendPostRequest(String route, String body, Function handler) async {
      Request req = Request(
        'POST',
        Uri.parse('$_rndUrl/$route'),
        body: body,
      );
      return await handler(req);         
    }

    group('get:', () {
      test('good id', () async {
        Response response = await sendGetRequest('?id=0');
        expect(response.statusCode, 200);
        expect(
          await response.readAsString(),
          userToJson(_mockUsers[0]),
        );
      });

      test('bad id', () async {
        Response response = await sendGetRequest('?id=999');
        expect(response.statusCode, 404);
      });

      test('missing id param', () async {
        Response response = await sendGetRequest('');
        expect(response.statusCode, 400);
      });
    });

    group('create:', () {
      test('good json', () async {
        String body = userToJson(anotherUser);
        Response response = await sendPostRequest('/user/profile/create', body, _controller.createUserHandler);
        expect(response.statusCode, 200);
        expect(await response.readAsString(), '44');
      });

      test('improperly formatted json', () async {
        String body = '{"string":"not a user"}';
        Response response = await sendPostRequest('/user/profile/create', body, _controller.createUserHandler);
        expect(response.statusCode, 400);
      });
    });
  });
}
