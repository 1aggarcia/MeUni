import 'package:firebase_dart/database.dart' as db;

import '../locator.dart';
import '../models/event.dart';

abstract class EventsRepo {
  //* Public Methods

  // Returns the ID of the newly created event
  Future<int> addEventAsync(Event event);

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
  Future<Event> getEventAsync(int id) {
    // TODO: implement getEventAsync
    throw UnimplementedError();
  }

  @override
  Future<Map<int, Event>> getEventsAsync() async {
    final db.DataSnapshot snapshot = await _eventsRef.once();
    print(snapshot.value);

    final Map<String, Object>? value = snapshot.value;

    if (value != null) {
      // TODO: Convert Map<String, Object> to Map<int, Event>
      throw UnimplementedError();
    } else {
      return {};
    }
  }
}
