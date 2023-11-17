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
    // TODO: implement addEventAsync
    _apiService.postAsync("/events/create", eventToJson(event));
  }

  @override
  Future<List<Event>> getEventsAsync() async {
    // TODO: implement getEventsAsync
    Response response = await _apiService.getAsync("/events/get");
    return eventsFromJson(response.body);
  }
}
