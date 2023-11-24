import 'dart:convert';

import 'package:http/http.dart';

import '../app/app.locator.dart';
import '../models/event.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

abstract class EventsRepo {
  //* Public Methods
  Future<Event?> getEventAsync(String id);
  Future<List<Event>> getEventsAsync({String? searchQuery});

  Future<bool> addEventAsync({
    required String title,
    required String desc,
    required String location,
    required int max,
    required DateTime startTime,
    required DateTime endTime,
  });

  Future<bool> joinEventAsync(String id);
  Future<bool> unJoinEventAsync(String id);
}

class EventsRepoImpl extends EventsRepo {
  //* Private Properties
  final _apiService = locator<ApiService>();
  final _authService = locator<AuthService>();

  //* Overridden Methods
  @override
  Future<Event?> getEventAsync(String id) async {
    var response = await _apiService.getAsync(
      Endpoints.getEvents,
      params: {'id': id},
    );

    if (!responseOk(response)) {
      return null;
    }

    return _eventFromJson(response.body);
  }

  @override
  Future<List<Event>> getEventsAsync({String? searchQuery}) async {
    Response response = await _apiService.getAsync(Endpoints.getEvents);

    if (!responseOk(response)) {
      return [];
    }

    return _eventsFromJson(response.body);
  }

  @override
  Future<bool> addEventAsync({
    required String title,
    required String desc,
    required String location,
    required int max,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    // Create the Event
    Event event = Event(
      id: '-1', // API creates an ID for us
      title: title,
      desc: desc,
      location: location,
      max: max,
      startTime: startTime,
      endTime: endTime,
      hostId: _authService.currUser.id,
      hostName: '[TEMP]', // API pulls this from hostId
      attendees: [],
    );

    var response = await _apiService.postAsync(
      Endpoints.createEvent,
      body: _eventToJson(event),
    );

    return responseOk(response);
  }

  @override
  Future<bool> joinEventAsync(String id) async {
    var response = await _apiService.postAsync(
      Endpoints.joinEvent,
      body: jsonEncode({
        'eventId': id,
        'userId': _authService.currUser.id,
      }),
    );

    return responseOk(response);
  }

  @override
  Future<bool> unJoinEventAsync(String id) async {
    var response = await _apiService.postAsync(
      Endpoints.unJoinEvent,
      body: jsonEncode({
        'eventId': id,
        'userId': _authService.currUser.id,
      }),
    );

    return responseOk(response);
  }

  //* Private Methods
  String _eventToJson(Event event) => json.encode(event.toJson());

  Event _eventFromJson(String json) => Event.fromJson(jsonDecode(json));

  List<Event> _eventsFromJson(String str) {
    // ignore: unnecessary_lambdas
    return List<Event>.from(jsonDecode(str).map((x) => Event.fromJson(x)));
  }
}
