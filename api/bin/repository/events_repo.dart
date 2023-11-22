import 'dart:convert';

import 'package:firebase_dart/database.dart' as db;

import '../locator.dart';
import '../models/event.dart';
import '../models/user_data.dart';

abstract class EventsRepo {
  //* Public Methods

  /// @returns the ID of the newly created event
  Future<String> addEventAsync(Event event);

  /// Removes event of given id from database
  /// @returns id of deleted event
  Future<String> deleteEventAsync(String id);

  /// @returns the Event if found, null otherwise
  Future<Event?> getEventAsync(String id);

  /// @returns list of all events
  Future<List<Event>> getEventsAsync();

  /// Adds user with given id to event with given id
  /// @returns new attendees list or null if event is at max capacity,
  /// or either id is invalid
  Future<List<String>?> joinEventAsync(String userId, String eventId);

  /// Removes user with given id from event with given id
  /// @returns new attendees list or null if event id is invalid
  Future<List<String>?> unjoinEventAsync(String userId, String eventId);
}

class EventsRepoImpl extends EventsRepo {
  //* Private Properties
  final String endpoint;
  final String paramName;

  late db.DatabaseReference _eventsRef;
  late UserData _userEventsTable;

  //* Constructors
  EventsRepoImpl(this.endpoint, this.paramName) {
    final dbRef = locator<db.DatabaseReference>();
    _eventsRef = dbRef.child(endpoint);

    final userEventsRef = dbRef.child('user_$endpoint');
    _userEventsTable = UserData(userEventsRef, paramName);
  }

  //* Overriden Methods
  @override
  Future<String> addEventAsync(Event event) async {
    final db.DatabaseReference newRef = _eventsRef.push();
    final Map<String, dynamic> eventJson = event.toJson();

    eventJson.remove('hostName');
    eventJson.remove('attendeeNames');
    await newRef.set(eventJson);

    return newRef.key as String;
  }

  @override
  Future<String> deleteEventAsync(String id) async {
    final db.DatabaseReference eventRef = _eventsRef.child(id);
    await eventRef.remove();
    await _userEventsTable.removeData(id);
    return id;
  }

  @override
  Future<Event?> getEventAsync(String id) async {
    final db.DataSnapshot snapshot = await _eventsRef.child(id).once();
    final Event? event = eventFromJson(jsonEncode(snapshot.value));
    if (event is Event) {
      event.id = id;
    }
    return event;
  }

  @override
  Future<List<Event>> getEventsAsync() async {
    final db.DataSnapshot snapshot = await _eventsRef.once();
    final json = jsonEncode(snapshot.value);
    return eventsFromJson(json);
  }

  @override
  Future<List<String>?> joinEventAsync(String userId, String eventId) async {
    if (!await userCanJoinAsync(userId, eventId)) {
      return null;
    } else {
      Event event = await getEventAsync(eventId) as Event;
      event.attendees.add(userId);

      await _eventsRef.child(eventId).update({'attendees': event.attendees});
      await _userEventsTable.add(userId, eventId);

      return event.attendees;
    }
  }

  @override
  Future<List<String>?> unjoinEventAsync(String userId, String eventId) async {
    Event? event = await getEventAsync(eventId);
    if (event == null) {
      return null;
    } else {
      event.attendees.remove(userId);

      await _eventsRef.child(eventId).update({'attendees': event.attendees});
      await _userEventsTable.removeUser(userId);

      return event.attendees;    
    }
  }   

  //* Helper methods

  /// Returns true iff userId and eventId passed in coorespond 
  /// to an existing user and event in the database, and the event has space
  Future<bool> userCanJoinAsync(String userId, String eventId) async{
    // TODO: check for user validity
    Event? event = await getEventAsync(eventId);
    return (event != null &&
        !event.attendees.contains(userId) &&
        event.attendees.length < event.max);
  }
}
