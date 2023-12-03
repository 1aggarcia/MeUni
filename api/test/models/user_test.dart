import 'dart:convert';

import 'package:test/test.dart';
import '../../bin/models/user.dart';

void main() {
  group('Users Model -', () {
    User freshman = User(
      id: '0',
      firstName: 'Freshman',
      lastName: 'H',
      year: 1,
      pronouns: 'She/her',
      admin: false,
    );
    User oldGuy = User(
      id: '1',
      firstName: 'Old',
      lastName: 'Guy',
      year: 4,
      pronouns: 'he/him',
      admin: true,
    );
    User freshmanCopy = User(
      id: '2',
      firstName: 'Freshman',
      lastName: 'H',
      year: 1,
      pronouns: 'She/her',
      admin: false,
    );

    Map<String, dynamic> freshmanJsonMap = {
      'id': '0',
      'firstName': 'Freshman',
      'lastName': 'H',
      'year': 1,
      'pronouns': 'She/her',
      'admin': false,
    };

    test('equals', () {
      expect(freshmanCopy.equals(freshman), true);
      expect(freshman.equals(freshmanCopy), true);

      expect(freshman.equals(oldGuy), false);
      expect(freshmanCopy.equals(oldGuy), false);
      expect(oldGuy.equals(freshman), false);
      expect(oldGuy.equals(freshmanCopy), false);
    });

    test('User.toJson', () {
      expect(freshman.toJson(), freshmanJsonMap);
    });

    test('userToJson', () {
      expect(userToJson(freshman), json.encode(freshmanJsonMap));
    });

    test('userFromJson', () {
      String json = '{"id":"0",'
      '"firstName":"Freshman",'
      '"lastName":"H",'
      '"year":1,'
      '"pronouns":"She/her",'
      '"admin":false}';

      expect(userFromJson(json)?.equals(freshman), true);
    });

    test('userFromJson - bad types', () {
      String json = '{"id":["ABCDE"],'
          '"firstName":1234,'
          '"lastName":"H",'
          '"year":1,'
          '"pronouns":"She/her",'
          '"admin":false}';

      expect(userFromJson(json), null);
    });

    test('userFromJson - year out of range', () {
      String jsonYearSmall = '{"id":"0",'
      '"firstName":"Freshman",'
      '"lastName":"H",'
      '"year":0,'
      '"pronouns":"She/her",'
      '"admin":false}';

      String jsonYearBig = '{"id":"0",'
      '"firstName":"Freshman",'
      '"lastName":"H",'
      '"year":5,'
      '"pronouns":"She/her",'
      '"admin":false}';

      expect(userFromJson(jsonYearSmall), null);
      expect(userFromJson(jsonYearBig), null);
    });

    test('userFromJson - short names', () {
      String jsonTooShort = '{"id":"0",'
      '"firstName":"",'
      '"lastName":"",'
      '"year":1,'
      '"pronouns":"She/her",'
      '"admin":false}';

      String jsonOk = '{"id":"0",'
      '"firstName":"a",'
      '"lastName":"a",'
      '"year":1,'
      '"pronouns":"She/her",'
      '"admin":false}';

      expect(userFromJson(jsonTooShort), null);
      expect(userFromJson(jsonOk) is User, true);
    });

    test('userFromJson - long names', () {
      String jsonTooLong = '{"id":"0",'
      '"firstName":"Hubert Blaine Wolfeschlegelsteinhausenbergerdorfslk",'
      '"lastName":"Hubert Blaine Wolfeschlegelsteinhausenbergerdorfslk",'
      '"year":1,'
      '"pronouns":"She/her",'
      '"admin":false}';
      String jsonOk = '{"id":"0",'
      '"firstName":"Hubert Blaine Wolfeschlegelsteinhausenbergerdorfsl",'
      '"lastName":"Hubert Blaine Wolfeschlegelsteinhausenbergerdorfsl",'
      '"year":1,'
      '"pronouns":"She/her",'
      '"admin":false}';

      expect(userFromJson(jsonTooLong), null);
      expect(userFromJson(jsonOk) is User, true);
    });

    test('usersToJson', () {
      List<User> data = [freshman, oldGuy];
      String test = usersToJson(data);
      expect(test, jsonEncode([freshman.toJson(), oldGuy.toJson()]));
    });

    test('usersFromMap', () {
      Map<String, dynamic> data = {
        '0': freshman.toJson(),
        '1': oldGuy.toJson(),
      };
      List<User> test = usersFromMap(data);
      expect(test.length, 2);
      for (int i = 0; i < test.length; i++) {
        expect(test[i].toJson(), data['$i']);
      }
    });

    test('usersFromMap - improper formatting', () {
      Map<String, dynamic> data = {
        '0': 'text',
        '1': 23,
      };
      List<User> test = usersFromMap(data);
      expect(test.length, 0);
    });

    test('usersFromJson', () {
      List<User> data = [freshman, oldGuy];
      String json = usersToJson(data);

      List<User> test = usersFromJson(json);
      expect(data.length, 2);
      for (int i = 0; i < test.length; i++) {
        expect(test[i], data[i]);
      }
    });

    test('usersFromJson - improper formatting', () {
      String json = jsonEncode([1, 2, 3, 4]);
      expect(usersFromJson(json), []);
    });

    test('userListToMap', () {
      Map<String, User> data = {
        '0': freshman,
        '1': oldGuy,
        '2': freshmanCopy,
      };
      List<User> list = [freshman, oldGuy, freshmanCopy];
      Map<String, User> test = userListToMap(list);

      expect(test.length, 3);
      test.forEach((k, v) {
        expect(test[k], data[k]);
      });
    });

    test('getUserName', () {
      Map<String, User> data = {
        '0': freshman,
        '1': oldGuy,
        '2': freshmanCopy,
      };
      expect(getUserName('0', data), 'Freshman H.'); 
      expect(getUserName('1', data), 'Old G.'); 
      expect(getUserName('4', data), '(N/A)'); 
    });
  });
}
