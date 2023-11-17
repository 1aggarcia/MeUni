import 'dart:convert';
import 'dart:math';

import 'package:firebase_dart/database.dart' as db;

import '../locator.dart';
import '../models/event.dart';

const maxEvents = 1 << 30; // 2^30 = 1,073,741,824

abstract class EventsRepo {
  //* Public Methods

  /// Returns the ID of the newly created event, or -1 if unsucessfull
  Future<int> addEventAsync(Event event);

  /// Returns ID of deleted event, or -1 if unsucessfull
  int deleteEventAsync(int id);

  /// Returns the Event if found, null otherwise
  Future<Event?> getEventAsync(int id);

  /// Returns map of all events
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
  Future<int> addEventAsync(Event event) async {
    // Find avaliable ID
    final rand = Random();
    int id = rand.nextInt(maxEvents);
    List<int> used = [id];
    db.DatabaseReference newEvent = _eventsRef.child("$id");
    db.DataSnapshot snapshot = await newEvent.once();

    // Condition on length prevents infinite loop
    while(snapshot.value != null && used.length < maxEvents) {
      // Given above condition, there must be an unused id that can be generated
      while (used.contains(id)) {
        id = rand.nextInt(maxEvents);
      }
      newEvent = _eventsRef.child("$id");
      snapshot = await newEvent.once();
    }

    // Create event
    newEvent.update({"titulo":"c"});

    return id;
  }

  @override
  int deleteEventAsync(int id) {
    // TODO: implement deleteEventAsync
    throw UnimplementedError();
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
}
