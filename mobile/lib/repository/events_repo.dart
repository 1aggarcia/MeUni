import 'package:meuni_mobile/models/event.dart';

abstract class EventsRepo {
  //* Public Methods
  Future<List<Event>> getEventsAsync();

  Future addEventAsync(Event event);
}
