import 'dart:convert';

import 'package:firebase_dart/database.dart' as db;

import '../locator.dart';
import '../models/event.dart';
import '../models/user_data.dart';

// const maxEvents = 1 << 30; // 2^30 = 1,073,741,824

abstract class EventsRepo {
  //* Public Methods

  /// @returns the ID of the newly created event
  String addEvent(Event event);

  /// Removes event of given id from database
  /// @returns id of deleted event
  String deleteEvent(String id);

  /// @returns the Event if found, null otherwise
  Future<Event?> getEventAsync(String id);

  /// @returns map of all events
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
  late db.DatabaseReference _eventsRef;
  late UserData _userEventsTable;

  //* Constructors
  EventsRepoImpl() {
    final dbRef = locator<db.DatabaseReference>();
    _eventsRef = dbRef.child('events');
    final userEventsRef = dbRef.child('user_events');
    _userEventsTable = UserData(userEventsRef, 'eventId');
  }

  //* Overriden Methods
  @override
  String addEvent(Event event) {
    final db.DatabaseReference newRef = _eventsRef.push();
    final Map<String, dynamic> eventJson = event.toJson();

    eventJson.remove('hostName');
    eventJson.remove('attendeeNames');
    newRef.update(eventJson);

    return newRef.key as String;
  }

  @override
  String deleteEvent(String id) {
    final db.DatabaseReference eventRef = _eventsRef.child(id);
    eventRef.remove();
    //_userEventsTable.removeDataAsync(id);
    return id;
  }

  @override
  Future<Event?> getEventAsync(String id) async {
    final db.DataSnapshot snapshot = await _eventsRef.child(id).once();
    final Event? event = eventFromJson(jsonEncode(snapshot.value));
    if (event is Event) {
      event.setId(id);
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
      Event? event = await getEventAsync(eventId) as Event;
      event.attendees.add(userId);
      final eventJson = event.toJson();
      eventJson.remove('hostName');
      eventJson.remove('attendeeNames');
      _eventsRef.child(eventId).update(eventJson);

      // TODO: create user table repo
      _userEventsTable.add(userId, eventId);

      return event.attendees;
    }
  }

  @override
  Future<List<String>?> unjoinEventAsync(String userId, String eventId) async {
    /*
      - verificar que evento existe
        - si no, devolvé null
      - obtiene referencia de evento
      - quitarle usuario de attendees
      - quitar entrada (userId, eventId) de user_events
      - actualizar evento
      - devolvé attendees
    */
    throw UnimplementedError();
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

  // /// Finds an avaliable id in the database
  // /// @returns new id and its DatabaseReference
  // Future<(int, db.DatabaseReference)> getNewRefAsync() async {
  //   final rand = Random();
  //   int id = rand.nextInt(maxEvents);
  //   List<int> used = [id];
  //   db.DatabaseReference newRef = _eventsRef.child("$id");
  //   db.DataSnapshot snapshot = await newRef.once();

  //   // Condition on length prevents infinite loop
  //   while(snapshot.value != null && used.length < maxEvents) {
  //     // Given above condition, there must be an unused id that can be generated
  //     while (used.contains(id)) {
  //       id = rand.nextInt(maxEvents);
  //     }
  //     newRef = _eventsRef.child("$id");
  //     snapshot = await newRef.once();
  //     used.add(id);
  //   }
  //   return(id, newRef);    
  // }
}
