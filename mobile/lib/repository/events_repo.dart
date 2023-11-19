import 'package:http/http.dart';

import '../app/app.locator.dart';
import '../models/event.dart';
import '../services/api_service.dart';

abstract class EventsRepo {
  //* Public Methods
  Future<List<Event>> getEventsAsync();

  Future addEventAsync(Event event);
}

class EventsRepoImpl extends EventsRepo {
  final ApiService _apiService = locator<ApiService>();

  @override
  Future addEventAsync(Event event) async {
    await _apiService.postAsync(
      Endpoints.createEvent,
      body: eventToJson(event),
    );
  }

  @override
  Future<List<Event>> getEventsAsync() async {
    Response response = await _apiService.getAsync(Endpoints.getEvents);
    return eventsFromJson(response.body);
  }
}
