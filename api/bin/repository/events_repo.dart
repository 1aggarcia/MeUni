import 'dart:convert';

import 'package:firebase_dart/database.dart' as db;

import '../locator.dart';
import '../models/event.dart';

abstract class EventsRepo {
  //* Public Methods

  // Returns the ID of the newly created event
  Future<int> addEventAsync(Event event);

  // Returns ID of deleted event, or -1 if unsucessfull
  int deleteEventAsync(int id);

  /// Returns the Event if found, null otherwise
  Future<Event?> getEventAsync(int id);

  /// Returns {} if no events
  Future<Map<int, Event>> getEventsAsync();
}

class EventsRepoImpl extends EventsRepo {
  //* Private Properties
  late db.DatabaseReference _eventsRef;

  //* Constructors
  EventsRepoImpl() {
    final dbRef = locator<db.DatabaseReference>();

    _eventsRef = dbRef.child('events');
  }

  //* Overriden Methods
  @override
  Future<int> addEventAsync(Event event) {
    // TODO: implement addEventAsync
    throw UnimplementedError();
  }

  @override
  int deleteEventAsync(int id) {
    // TODO: implement deleteEventAsync
    throw UnimplementedError();
  }

  @override
  Future<Event> getEventAsync(int id) async {
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
}
