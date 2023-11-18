import 'dart:convert';

import 'package:test/test.dart';
import '../../bin/models/event.dart';

void main() {
  group('Events Model -', () {
    Event evt = Event(
      title: 'Another event',
      desc: 'This time i really need people',
      location: '[Redacted]',
      max: 2,
      startTime: DateTime.parse('2023-11-05 03:04:15.537017Z'),
      endTime: DateTime.parse('2023-11-05 03:24:15.537017Z'),
      hostId: "3",
      hostName: 'Hannah',
      attendees: ["1"],
      attendeeNames: ['Fei'],
    );

    // copy of evt
    Event evtA = Event(
      title: 'Another event',
      desc: 'This time i really need people',
      location: '[Redacted]',
      max: 2,
      startTime: DateTime.parse('2023-11-05 03:04:15.537017Z'),
      endTime: DateTime.parse('2023-11-05 03:24:15.537017Z'),
      hostId: "3",
      hostName: 'Hannah',
      attendees: ["1"],
      attendeeNames: ['Fei'],    
    );

    Event evtB = Event(
        title: 'Pizza',
        desc: 'need ppl to chip in for pizza',
        location: 'The crib',
        max: 4,
        startTime: DateTime.parse('2023-11-04 03:04:15.537017Z'),
        endTime: DateTime.parse('2023-11-04 03:24:15.537017Z'),
        hostName: 'Fei',
        hostId: "1",
        attendees: ["2", "3"],
        attendeeNames: ['John', 'Hannah'],
    );

    test('equals', () {
      expect(evtA.equals(evt), true);
      expect(evt.equals(evtA), true);

      expect(evtA.equals(evtB), false);
      expect(evt.equals(evtB), false);
      expect(evtB.equals(evtA), false);
      expect(evtB.equals(evt), false);
    });

    test('Event.toJson()', () {
      Map<String, dynamic> jsonMap = {
          "title": 'Another event',
          "desc": 'This time i really need people',
          "location": '[Redacted]',
          "max": 2,
          "startTime": "2023-11-05T03:04:15.537017Z",
          "endTime": "2023-11-05T03:24:15.537017Z",
          "hostId": "3",
          "hostName": 'Hannah',
          "attendees": ["1"],
          "attendeeNames": ['Fei'],
      };
      expect(evt.toJson(), jsonMap);
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
          '"max": "34",'
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
      final int maxCapacity = 15;
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
          '"max": ${maxCapacity+1},'
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

    test('fromJsonMap', () {
      Map<String, dynamic> data = {
        "0":evt.toJson(), "1":evtA.toJson(), "2":evtB.toJson()
      };
      Map<int, Event> events = fromJsonMap(data);
      events.forEach((k, v) {
        Event? fromJson = eventFromJson(data["$k"].toString());
        if (fromJson != null) {
          expect(v.equals(fromJson), true);
        }
      });
    });

    test('toJsonMap', () {
      Map<int, Event> data = {
        0:evt, 1:evtA, 2:evtB
      };
      Map<String, dynamic> json = toJsonMap(data);
      json.forEach((k, v) {
        expect(jsonEncode(v) == eventToJson(data[int.parse(k)] as Event), true);
      });
    });

    test('eventsFromJson', () {
      Map<int, Event> data = {
        0:evt, 1:evtA, 2:evtB
      };
      String json = jsonEncode(toJsonMap(data));
      Map<int, Event> events = eventsFromJson(json);
      expect(events.length, 3);
      events.forEach((k, v) {
        expect(v.equals(data[k] as Event), true);
      });   
    });

    test('eventsFromJson - bad json', () {
      String json = jsonEncode([1, 2, 3, 4]);
      expect(eventsFromJson(json), {});
    });

    test('eventsToJson', () {
      Map<int, Event> data = {
        0:evt, 1:evtA, 2:evtB
      };
      String json = eventsToJson(data);
      expect(json, jsonEncode(toJsonMap(data))); 
    });
  });
}