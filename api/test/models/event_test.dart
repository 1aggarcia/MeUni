import 'dart:convert';

import 'package:test/test.dart';
import '../../bin/models/event.dart';

void main() {
  group('Events Model -', () {
    Event evt = Event(
      id: '0',
      title: 'Another event',
      desc: 'This time i really need people',
      location: '[Redacted]',
      max: 2,
      startTime: DateTime.parse('2023-11-05 03:04:15.537017Z'),
      endTime: DateTime.parse('2023-11-05 03:24:15.537017Z'),
      hostId: '3',
      hostName: '[unknown user]',
      attendees: ['1'],
      attendeeNames: ['[unknown user]'],
    );

    // copy of evt
    Event evtA = Event(
      id: '1',
      title: 'Another event',
      desc: 'This time i really need people',
      location: '[Redacted]',
      max: 2,
      startTime: DateTime.parse('2023-11-05 03:04:15.537017Z'),
      endTime: DateTime.parse('2023-11-05 03:24:15.537017Z'),
      hostId: '3',
      hostName: '[unknown user]',
      attendees: ['1'],
      attendeeNames: ['[unknown user]'],
    );

    Event evtB = Event(
      id: '2',
      title: 'Pizza',
      desc: 'need ppl to chip in for pizza',
      location: 'The crib',
      max: 4,
      startTime: DateTime.parse('2023-11-04 03:04:15.537017Z'),
      endTime: DateTime.parse('2023-11-04 03:24:15.537017Z'),
      hostName: '[unknown user]',
      hostId: '1',
      attendees: ['2', '3'],
      attendeeNames: ['[unknown user]', '[unknown user]'],
    );

    Map<String, dynamic> evtJsonMap = {
      'id': '0',
      'title': 'Another event',
      'desc': 'This time i really need people',
      'location': '[Redacted]',
      'max': 2,
      'startTime': '2023-11-05T03:04:15.537017Z',
      'endTime': '2023-11-05T03:24:15.537017Z',
      'hostId': '3',
      'hostName': '[unknown user]',
    };

    Map<String, dynamic> evtJsonMapFull = {
      'title': 'Another event',
      'desc': 'This time i really need people',
      'location': '[Redacted]',
      'max': 2,
      'startTime': '2023-11-05T03:04:15.537017Z',
      'endTime': '2023-11-05T03:24:15.537017Z',
      'hostId': '3',
      'hostName': '[unknown user]',
      'attendees': ['1'],
      'attendeeNames': ['[unknown user]'],
    };

    test('equals', () {
      expect(evtA.equals(evt), true);
      expect(evt.equals(evtA), true);

      expect(evtA.equals(evtB), false);
      expect(evt.equals(evtB), false);
      expect(evtB.equals(evtA), false);
      expect(evtB.equals(evt), false);
    });

    test('Event.toJson', () {
      expect(evt.toJson(), evtJsonMap);
    });

    test('Event.toJsonFull', () {
      expect(evt.toJsonFull(), evtJsonMapFull);
    });

    test('eventToJson', () {
      expect(eventToJson(evt), json.encode(evtJsonMapFull));
    });

    test('eventFromJson', () {
      String json = '{"title": "Another event",'
          '"desc": "This time i really need people",'
          '"location": "[Redacted]",'
          '"max": 2,'
          '"startTime": "2023-11-05T03:04:15.537017Z",'
          '"endTime": "2023-11-05T03:24:15.537017Z",'
          '"hostId": "3",'
          '"attendees": ["1"]}';
      Event? fromJson = eventFromJson(json);
      expect(fromJson is Event, true);
      expect(evt.equals(fromJson as Event), true);
    });

    test('eventFromJson - bad types', () {
      String json = '{"title": "Another event",'
          '"desc": "This time i really need people",'
          '"location": "[Redacted]",'
          '"max": "3",'
          '"startTime": "2023-11-05T03:04:15.537017Z",'
          '"endTime": "2023-11-05T03:24:15.537017Z",'
          '"hostId": "3",'
          '"attendees": ["1"]}';
      Event? fromJson = eventFromJson(json);
      expect(fromJson, null);

      json = '{"title": "Another event",'
          '"desc": "This time i really need people",'
          '"location": "[Redacted]",'
          '"max": 4,'
          '"startTime": "2023-11-05T03:04:15.537017Z",'
          '"endTime": "2023-11-05T03:24:15.537017Z",'
          '"hostId": "3",'
          '"attendees": "hi"}';
      fromJson = eventFromJson(json);
      expect(fromJson, null);
    });

    test('eventFromJson - max out of range', () {
      // Invalid max
      String json = '{"title": "Another event",'
          '"desc": "This time i really need people",'
          '"location": "[Redacted]",'
          '"max": 0,'
          '"startTime": "2023-11-05T03:04:15.537017Z",'
          '"endTime": "2023-11-05T03:24:15.537017Z",'
          '"hostId": "3",'
          '"attendees": ["1"]}';
      Event? fromJson = eventFromJson(json);
      expect(fromJson, null);

      json = '{"title": "Another event",'
          '"desc": "This time i really need people",'
          '"location": "[Redacted]",'
          '"max": ${maxCapacity + 1},'
          '"startTime": "2023-11-05T03:04:15.537017Z",'
          '"endTime": "2023-11-05T03:24:15.537017Z",'
          '"hostId": "3",'
          '"attendees": ["1"]}';
      fromJson = eventFromJson(json);
      expect(fromJson, null);

      // Valid max
      json = '{"title": "Another event",'
          '"desc": "This time i really need people",'
          '"location": "[Redacted]",'
          '"max": 1,'
          '"startTime": "2023-11-05T03:04:15.537017Z",'
          '"endTime": "2023-11-05T03:24:15.537017Z",'
          '"hostId": "3",'
          '"attendees": ["1"]}';
      fromJson = eventFromJson(json);
      expect(fromJson is Event, true);

      json = '{"title": "Another event",'
          '"desc": "This time i really need people",'
          '"location": "[Redacted]",'
          '"max": $maxCapacity,'
          '"startTime": "2023-11-05T03:04:15.537017Z",'
          '"endTime": "2023-11-05T03:24:15.537017Z",'
          '"hostId": "3",'
          '"attendees": ["1"]}';
      fromJson = eventFromJson(json);
      expect(fromJson is Event, true);
    });

    test('eventsToJson', () {
      List<Event> data = [evt, evtA, evtB];
      String test = eventsToJson(data);
      expect(test, jsonEncode([evt.toJson(), evtA.toJson(), evtB.toJson()]));
    });

    test('eventsFromMap', () {
      Map<String, dynamic> data = {
        '0': evt.toJson(),
        '1': evtA.toJson(),
        '2': evtB.toJson()
      };
      List<Event> test = eventsFromMap(data);
      expect(test.length, 3);
      for (int i = 0; i < test.length; i++) {
        expect(test[i].toJson(), data['$i']);
      }
    });

    test('eventsFromMap - improper formatting', () {
      Map<String, dynamic> data = {
        '1': 'hola',
        '2': 23,
        '0': evt.toJson(),
      };
      List<Event> test = eventsFromMap(data);
      expect(test.length, 1);
      expect(test[0].toJson(), data['0']);
    });

    test('eventsFromJson', () {
      List<Event> data = [evt, evtA, evtB];
      String json = eventsToJson(data);

      List<Event> test = eventsFromJson(json);
      expect(data.length, 3);
      for (int i = 0; i < test.length; i++) {
        expect(test[i], data[i]);
      }
    });

    test('eventsFromJson - improper formatting', () {
      String json = jsonEncode([1, 2, 3, 4]);
      expect(eventsFromJson(json), []);
    });

    // test('eventsToJson', () {
    //   Map<String, Event> data = {
    //     "0":evt, "1":evtA, "2":evtB
    //   };
    //   String json = eventsToJson(data);
    //   expect(json, jsonEncode(toJsonMap(data)));
    // });

    // test('toJsonMap', () {
    //   Map<String, Event> data = {
    //     "0":evt, "1":evtA,"2":evtB
    //   };
    //   Map<String, dynamic> json = toJsonMap(data);
    //   expect(data.length, 3);
    //   json.forEach((k, v) {
    //     expect(data[k] is Event, true);
    //     expect(jsonEncode(v) == eventToJson(data[k] as Event), true);
    //   });
    // });
  });
}
