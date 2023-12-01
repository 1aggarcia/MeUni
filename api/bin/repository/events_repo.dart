import 'dart:convert';

import 'package:firebase_dart/database.dart' as db;
import 'package:string_similarity/string_similarity.dart';

import '../locator.dart';
import '../models/event.dart';
//import '../models/user.dart';
import '../models/user.dart';
import '../models/user_data.dart';
import 'users_repo.dart';
//import 'users_repo.dart';

// Weight must be between 0-1
final double titleSearchWeight = 1;
final double descSearchWeight = 2/3;
final double locSearchWeight = 1/2;

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
  final UsersRepo _userRepo = locator<UsersRepo>();
  late db.DatabaseReference _eventsRef;
  late UserData _userEventsTable;

  //* Public Properties
  final String endpoint;
  final String paramName;

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

    eventJson.remove('id');
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
    // List reversed to have most recent event first
    List<Event> events = eventsFromJson(json).reversed.toList();

    return injectNames(events);
  }

  @override
  Future<Event?> getEventAsync(String id) async {
    final db.DataSnapshot snapshot = await _eventsRef.child(id).once();
    final Event? event = eventFromJson(jsonEncode(snapshot.value));
    if (event is Event) {
      event.id = id;
    }
    if (event == null) {
      return null;
    } else {
      // Convert 1 event to list so to find the hostName with injectNames
      List<Event> list = await injectNames([event]);
      // Get 1 event from list
      return list.first;
    }
  }

  @override
  Future<List<Event>> rankEventsAsync(String query) async {
    final List<Event> all = await getEventsAsync();
    final List<Event> result = [];

    for (Event event in all) {
      if (scoreEvent(event, query) > 0) {
        result.add(event);
      }
    }

    result.sort((a, b) => compareScore(a, b, query));
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

  /// Comparator function to sort a list of events by score of relevance to given query
  int compareScore(Event a, Event b, String query) {
    return scoreEvent(b, query).compareTo(scoreEvent(a, query));
  }

  /// Find the host name and attendee Names for every event given and inject them into each event
  /// * @returns list of events passed in with names if avaliable in database
  Future<List<Event>> injectNames(List<Event> events) async {
    List<User> userList = await _userRepo.getUsersAsync();
    Map<String, User> users = userListToMap(userList);
    List<Event> result = [];

    for (Event event in events) {
      Event copy = event.clone();
      copy.hostName = getUserName(copy.hostId, users);
      for (String att in copy.attendees) {
        copy.attendeeNames.add(getUserName(att, users));
      }
      result.add(copy);
    }

    return result;
  }

  /// Assign the given event a score of relevance to the given query (case insensitive)
  /// * if query has an exact match in event text, score = 1
  /// * otherwise, score = string similarity based on Dice's Coefficient, between 0-1
  double scoreEvent(Event event, String query) {
    final String lowerQuery = query.toLowerCase();
    final String lowerTitle = event.title.toLowerCase();
    final String lowerDesc = event.desc.toLowerCase();
    final String lowerLoc = event.location.toLowerCase();

    if ((lowerTitle + lowerDesc + lowerLoc).contains(lowerQuery)) {
      return 1;
    } else {
      final double titleScore = lowerTitle.similarityTo(lowerQuery) *titleSearchWeight;
      final double descScore = lowerDesc.similarityTo(lowerQuery) *descSearchWeight;
      final double locScore = lowerLoc.similarityTo(lowerQuery) *locSearchWeight;
      return (titleScore + descScore + locScore) / 3;
    }
  }

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
