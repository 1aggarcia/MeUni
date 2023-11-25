import 'dart:convert';

import 'package:firebase_dart/database.dart' as db;
import 'package:string_similarity/string_similarity.dart';

import '../locator.dart';
import '../models/event.dart';
import '../models/user_data.dart';

final double titleSearchWeight = 1;
final double descSearchWeight = 2/3;

abstract class EventsRepo {
  //* Public Methods

  /// @returns the ID of the newly created event
  Future<String> addEventAsync(Event event);

  /// Removes event of given id from database
  /// @returns id of deleted event
  Future<String> deleteEventAsync(String id);

  /// @returns list of all events
  Future<List<Event>> getEventsAsync();

  /// @returns list of events ranked in order of relevance between query and title/desc
  Future<List<Event>> rankEventsAsync(String query);

  /// @returns the Event if found, null otherwise
  Future<Event?> getEventAsync(String id);

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
    _userEventsTable = UserData(userEventsRef);
  }

  //* Overriden Methods
  @override
  Future<String> addEventAsync(Event event) async {
    final db.DatabaseReference newRef = _eventsRef.push();
    final Map<String, dynamic> eventJson = event.toJson();

    eventJson.remove('hostName');
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
  Future<List<Event>> getEventsAsync() async {
    final db.DataSnapshot snapshot = await _eventsRef.once();
    final json = jsonEncode(snapshot.value);
    return eventsFromJson(json);
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
  // Can be optimized to do n query scorings instead of n*log(n)
  Future<List<Event>> rankEventsAsync(String query) async {
    final List<Event> all = await getEventsAsync();
    final List<Event> result = [];

    String eventText;
    for (Event event in all) {
      eventText = event.title + event.desc;
      // Events scored n times
      if (eventText.similarityTo(query.toLowerCase()) > 0) {
        result.add(event);
      }
    }
    // Events re-scored n*log(n) times
    result.sort((a, b) => eventCompare(a, b, query));

    return result;
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

  int eventCompare(Event a, Event b, String query) {
    final String lowerQuery = query.toLowerCase();

    double scoreA = a.title.toLowerCase().similarityTo(lowerQuery) *titleSearchWeight;
    scoreA += a.desc.toLowerCase().similarityTo(lowerQuery) *descSearchWeight;

    double scoreB = b.title.toLowerCase().similarityTo(lowerQuery) *titleSearchWeight;
    scoreB += b.desc.toLowerCase().similarityTo(lowerQuery) *descSearchWeight;

    return scoreB.compareTo(scoreA);
  }
}
