import 'package:firebase_dart/database.dart' as db;

import '../locator.dart';
import '../models/event.dart';

abstract class EventsRepo {
  //* Public Methods

  Future<Event> addEventAsync(Event event);

  /// Returns the Event if found, null otherwise
  Future<Event?> getEventAsync(int id);

  /// Returns [] if no events
  Future<List<Event>> getEventsAsync();
}

class EventsRepoImpl extends EventsRepo {
  //* Private Properties
  late db.DatabaseReference _db;

  //* Constructors
  EventsRepoImpl() {
    final dbRef = locator<db.DatabaseReference>();

    _db = dbRef.child('events');
  }

  //* Overriden Methods
  @override
  Future<Event> addEventAsync(Event event) {
    // TODO: implement addEventAsync
    throw UnimplementedError();
  }

  @override
  Future<Event> getEventAsync(int id) {
    // TODO: implement getEventAsync
    throw UnimplementedError();
  }

  @override
  Future<List<Event>> getEventsAsync() async {
    final db.DataSnapshot snapshot = await _db.once();
    print(snapshot.value);

    final List<Object>? value = snapshot.value;

    if (value != null) {
      // TODO: Convert List<Object>? to List<Event>
      throw UnimplementedError();
    } else {
      throw [];
    }
  }
}
