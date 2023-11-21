import 'dart:convert';

import 'package:http/http.dart';

import '../app/app.locator.dart';
import '../models/event.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

abstract class EventsRepo {

  //* Public Methods
  Future<List<Event>> getEventsAsync();

  Future<void> addEventAsync(Event event);
  Future<void> joinEventAsync(String id);
  Future<Event?> getEventAsync(String id);

  }

class EventsRepoImpl extends EventsRepo {
  //* Private Properties
  final ApiService _apiService = locator<ApiService>();

  //* Overridden Methods
  @override
  Future<void> addEventAsync(Event event) async {
    await _apiService.postAsync(
      Endpoints.createEvent,
      body: _eventToJson(event),
    );
  }

  @override
  Future<List<Event>> getEventsAsync() async {
    Response response = await _apiService.getAsync(Endpoints.getEvents);
    return _eventsFromJson(response.body);
  }

  @override
  Future<Event?> getEventAsync(String id) async {
    throw UnimplementedError();
  }

  //* Private Methods
  String _eventToJson(Event event) => json.encode(event.toJson());

  List<Event> _eventsFromJson(String str) {
    final jsonMap = json.decode(str);

    return List<Event>.from(jsonMap.map(Event.fromJson));
  }

  @override
  Future<void> joinEventAsync(String id) async {
    // TODO: implement joinEventAsync
    throw UnimplementedError();
  }
}
