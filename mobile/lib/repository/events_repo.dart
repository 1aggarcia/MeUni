import '../models/event.dart';

abstract class EventsRepo {
  //* Public Methods
  Future<List<Event>> getEventsAsync();

  Future addEventAsync(Event event);
}
