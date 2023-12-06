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

    Future<Response> sendGetRequest(String args, Function handler) async {
        Request req = Request(
          'GET',
          Uri.parse('$_rndUrl/user/$args'),
        );
        return await handler(req);
    }

    Future<Response> sendPostRequest(String route, String body, Function handler) async {
      Request req = Request(
        'POST',
        Uri.parse('$_rndUrl/$route'),
        body: body,
      );
      return await handler(req);         
    }

    group('profile/get:', () {
      test('good id', () async {
        Response response = await sendGetRequest('profile?id=0', _controller.getUserHandler);
        expect(response.statusCode, 200);
        expect(
          await response.readAsString(),
          userToJson(_mockUsers[0]),
        );
      });

      test('bad id', () async {
        Response response = await sendGetRequest('profile?id=999', _controller.getUserHandler);
        expect(response.statusCode, 404);
      });

      test('missing id param', () async {
        Response response = await sendGetRequest('profile', _controller.getUserHandler);
        expect(response.statusCode, 400);
      });
    });

    group('profile/create:', () {
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

    group('courses/get:', () {
      test('good id', () async {
        Response response = await sendGetRequest('courses/get?id=a3242', _controller.getUserCoursesHandler);
        expect(response.statusCode, 200);

        response = await sendGetRequest('courses/get?id=lfj3qe9r', _controller.getUserCoursesHandler);
        expect(response.statusCode, 200);
      });

      test('missing id', () async {
        Response response = await sendGetRequest('courses/get', _controller.getUserCoursesHandler);
        expect(response.statusCode, 400);

        response = await sendGetRequest('courses/get?otherparam=kf23', _controller.getUserCoursesHandler);
        expect(response.statusCode, 400);
      });
    });

    group('courses/add:', () {
      test('good input', () async {
        String body = '{"userId":"2c","course":"MATH 101"}';
        Response response = 
          await sendPostRequest('/user/courses/add', body, _controller.addUserCoursesHandler);
        expect(response.statusCode, 200);

        body = '{"userId":"2asd2c","course":"LING 341"}';
        response = 
          await sendPostRequest('/user/courses/add', body, _controller.addUserCoursesHandler);
        expect(response.statusCode, 200);
      });

      test('missing params', () async {
        String body = '{"userId":"2c"}';
        Response response = 
          await sendPostRequest('/user/courses/add', body, _controller.addUserCoursesHandler);
        expect(response.statusCode, 400);

        body = '{"course":"LING 341"}';
        response = 
          await sendPostRequest('/user/courses/add', body, _controller.addUserCoursesHandler);
        expect(response.statusCode, 400);
      });

      test('params of wrong type', () async {
        String body = '{"userId":"2c","course":234}';
        Response response = 
          await sendPostRequest('/user/courses/add', body, _controller.addUserCoursesHandler);
        expect(response.statusCode, 400);

        body = '{"userId":false,"course":"LING 341"}';
        response = 
          await sendPostRequest('/user/courses/add', body, _controller.addUserCoursesHandler);
        expect(response.statusCode, 400);
      });
    });

    group('courses/remove:', () {
      test('good input', () async {
        String body = '{"userId":"2c","course":"MATH 101"}';
        Response response = 
          await sendPostRequest('/user/courses/remove', body, _controller.removeUserCoursesHandler);
        expect(response.statusCode, 200);

        body = '{"userId":"2asd2c","course":"LING 341"}';
        response = 
          await sendPostRequest('/user/courses/remove', body, _controller.removeUserCoursesHandler);
        expect(response.statusCode, 200);
      });

      test('missing params', () async {
        String body = '{"userId":"2c"}';
        Response response = 
          await sendPostRequest('/user/courses/remove', body, _controller.removeUserCoursesHandler);
        expect(response.statusCode, 400);

        body = '{"course":"LING 341"}';
        response = 
          await sendPostRequest('/user/courses/remove', body, _controller.removeUserCoursesHandler);
        expect(response.statusCode, 400);
      });

      test('params of wrong type', () async {
        String body = '{"userId":"2c","course":234}';
        Response response = 
          await sendPostRequest('/user/courses/remove', body, _controller.removeUserCoursesHandler);
        expect(response.statusCode, 400);

        body = '{"userId":false,"course":"LING 341"}';
        response = 
          await sendPostRequest('/user/courses/remove', body, _controller.removeUserCoursesHandler);
        expect(response.statusCode, 400);
      });
    });
  });
}
