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
  Future<List<Event>> getEventsAsync() {
    // TODO: implement getEventsAsync
    throw UnimplementedError();
  }
}
