import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'dart:convert';

import '../locator.dart';
import '../models/event.dart';
import '../repository/events_repo.dart';
import 'controller.dart';

class EventController extends Controller {
  //* Private Properties
  final _eventsRepo = locator<EventsRepo>();

  //* Overriden Methods
  @override
  Router setUpRoutes(Router router, String endpoint) {
    return router
      ..get('$endpoint/get', getEventsHandler)
      ..post('$endpoint/create', postEventsHandler)
      ..post('$endpoint/delete', deleteEventsHandler);
  }

  //* Public API Methods

  // GET /
  /// Optional id parameter
  /// Returns event with given id or list of all events, if param not included
  Future<Response> getEventsHandler(Request request) async {
    Map<String, dynamic> params = request.url.queryParameters;

    if (params.containsKey('id')) {
      try {
        int eventId = int.parse(params['id']);
        Event? event = await _eventsRepo.getEventAsync(eventId);

        if (event != null) {
          return Response.ok(eventToJson(event));
        } else {
          return Response(400);
        }
      } catch (e) {
        print("Failed to get event: $e");
        return Response(400);
      }
    } else {
      Map<int, Event> events = await _eventsRepo.getEventsAsync();
      return Response.ok(eventsToJson(events));
    }
  }

  // POST /
  Future<Response> postEventsHandler(Request request) async {
    String body = await request.readAsString();

    try {
      Event? event = eventFromJson(body);
      if (event != null) {
        int newId = await _eventsRepo.addEventAsync(event);
        return Response.ok("$newId");
      } else {
        return Response(400);
      }
    } catch (e) {
      print(e);
      return Response(400);
    }
  }

  Future<Response> deleteEventsHandler(Request request) async {
    String json = await request.readAsString();

    try {
      dynamic body = jsonDecode(json);
      int? id = body['id'];
      if (id != null) {
        int result = _eventsRepo.deleteEventAsync(id);
        return Response.ok("$result");
      } else {
        return Response(400);
      }
    } catch (e) {
      print(e);
      return Response(400);
    }
  }
}
