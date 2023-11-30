// import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../../bin/controllers/user_controller.dart';
import '../../bin/locator.dart';
// import '../../bin/models/user.dart';
import '../../bin/repository/mock/mock_users_repo.dart';
import '../../bin/repository/users_repo.dart';

// final String _rndUrl = 'https://example.com';

// UserController _controller = UserController();

void main() {
  group('Users Controller -', () {
    setUp(() async {
      await locator.reset();

      locator.registerLazySingleton<UsersRepo>(MockUsersRepo.new);

      _controller = UserController();
    });

  //   test('GET user profile', () async {
  //     Request req = Request(
  //       'GET',
  //       Uri.parse('$_rndUrl/profile/get?id=1a'),
  //     );
  //     Response response = await _controller.getUserHandler(req);

  //     expect(response.statusCode, 200);
  //     expect(
  //         await response.readAsString(),
  //         '{"id":"1a",'
  //         '"firstName":"Fei",'
  //         '"lastName":"Huang",'
  //         '"year":4,'
  //         '"pronouns":"He/Him",'
  //         '"admin":true}');
  //   });
  // });

  // Future<Response> sendGetRequest(String args) async {
  //   Request req = Request(
  //     'GET',
  //     Uri.parse('$_rndUrl/events/get$args'),
  //   );
  //   return await _controller.getUserHandler(req);
  // }

  // group('get:', () {
  //   test('user1', () async {
  //     User user1 = User(
  //         id: '0',
  //         firstName: 'Adam',
  //         lastName: 'Smith',
  //         year: 1,
  //         pronouns: 'He/Him',
  //         admin: true);

  //     String userJson = userToJson(user1);

  //     Response response = await sendGetRequest(userJson);
  //     expect(response.statusCode, 200);

  //     response = await sendGetRequest('?id=0');
  //     expect(response.statusCode, 200);
  //     expect(userJson, await response.readAsString());
  //   });
  });
}
