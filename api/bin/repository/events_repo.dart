import 'dart:convert';
import 'dart:math';

import 'package:firebase_dart/database.dart' as db;

import '../locator.dart';
import '../models/event.dart';

const maxEvents = 1 << 30; // 2^30 = 1,073,741,824

abstract class EventsRepo {
  //* Public Methods

  /// Returns the ID of the newly created event
  Future<int> addEventAsync(Event event);

  /// Removes event of given id from database, returns id of deleted event
  int deleteEvent(int id);

  /// Returns the Event if found, null otherwise
  Future<Event?> getEventAsync(int id);

  /// Returns map of all events
  Future<Map<int, Event>> getEventsAsync();

  /// Adds user with given id to event with given id
  /// Returns new attendees list or null if event is at max capacity,
  /// or either id is invalid
  Future<List<String>?> joinEventAsync(String userId, int eventId);
}

class EventsRepoImpl extends EventsRepo {
  //* Private Properties
  late db.DatabaseReference _eventsRef;
  late db.DatabaseReference _userEventsRef;

  //* Constructors
  EventsRepoImpl() {
    final dbRef = locator<db.DatabaseReference>();

    _eventsRef = dbRef.child('events');
    _userEventsRef = dbRef.child('user_events');
  }

  //* Overriden Methods
  @override
  Future<int> addEventAsync(Event event) async {
    final (id, newRef) = await getNewRefAsync();
    final Map<String, dynamic> eventJson = event.toJson();
    eventJson.remove('hostName');
    eventJson.remove('attendeeNames');
    newRef.update(eventJson);
    return id;
  }

  @override
  int deleteEvent(int id) {
    final db.DatabaseReference eventRef = _eventsRef.child("$id");
    eventRef.remove();
    return id;
  }

  @override
  Future<Event?> getEventAsync(int id) async {
    final db.DataSnapshot snapshot = await _eventsRef.child("$id").once();
    final json = jsonEncode(snapshot.value);
    return eventFromJson(json);
  }

  @override
  Future<Map<int, Event>> getEventsAsync() async {
    final db.DataSnapshot snapshot = await _eventsRef.once();
    final json = jsonEncode(snapshot.value);
    return eventsFromJson(json);
  }

  @override
  Future<List<String>?> joinEventAsync(String userId, int eventId) async {
    if (!await userCanJoinAsync(userId, eventId)) {
      return null;
    } else {
      Event? event = await getEventAsync(eventId) as Event;
      event.attendees.add(userId);
      final eventJson = event.toJson();
      eventJson.remove('hostName');
      eventJson.remove('attendeeNames');
      _eventsRef.child("$eventId").update(eventJson);

      db.DatabaseReference userLog = _userEventsRef.push();
      userLog.update({
        "userId": userId,
        "eventId": eventId
      });

      return event.attendees;
    }
  }  

  //* Helper methods

  /// Returns true iff userId and eventId passed in coorespond 
  /// to an existing user and event in the database, and the event has space
  Future<bool> userCanJoinAsync(String userId, int eventId) async{
    // TODO: check for user validity
    Event? event = await getEventAsync(eventId);
    if (event != null) {
      print("c1 exists true");
      print("c2 user not joined ${!event.attendees.contains(userId)}");
      print("c3 event has capacity ${event.attendees.length < event.max}");
    } else {
      print("c1 exists false");
    }
    return (event != null &&
        !event.attendees.contains(userId) &&
        event.attendees.length < event.max);
  }

  /// Finds an avaliable id in the database
  /// returns new id and its DatabaseReference
  Future<(int, db.DatabaseReference)> getNewRefAsync() async {
    final rand = Random();
    int id = rand.nextInt(maxEvents);
    List<int> used = [id];
    db.DatabaseReference newRef = _eventsRef.child("$id");
    db.DataSnapshot snapshot = await newRef.once();

    // Condition on length prevents infinite loop
    while(snapshot.value != null && used.length < maxEvents) {
      // Given above condition, there must be an unused id that can be generated
      while (used.contains(id)) {
        id = rand.nextInt(maxEvents);
      }
      newRef = _eventsRef.child("$id");
      snapshot = await newRef.once();
      used.add(id);
    }
    return(id, newRef);    
  }
}
