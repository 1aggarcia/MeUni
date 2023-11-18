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
      ..post('$endpoint/delete', deleteEventsHandler)
      ..post('$endpoint/join', joinEventsHandler)
      ..post('$endpoint/unjoin', unjoinEventsHandler);
  }

  //* Public API Methods

  // GET /
  /// Optional id parameter
  /// Returns event with given id or list of all events, if param not included
  Future<Response> getEventsHandler(Request request) async {
    Map<String, dynamic> params = request.url.queryParameters;

    if (params.containsKey('id')) {
      try {
        Event? event = await _eventsRepo.getEventAsync(params['id']);

        if (event != null) {
          return Response.ok(eventToJson(event));
        } else {
          return Response(400);
        }
      } catch (e) {
        return Response(400);
      }
    } else {
      Map<String, Event> events = await _eventsRepo.getEventsAsync();
      return Response.ok(eventsToJson(events));
    }
  }

  // POST /
  Future<Response> postEventsHandler(Request request) async {
    String body = await request.readAsString();

    try {
      Event? event = eventFromJson(body);
      if (event != null) {
        String newId = _eventsRepo.addEvent(event);
        return Response.ok(newId);
      } else {
        return Response(400);
      }
    } catch (e) {
      return Response(400);
    }
  }

  Future<Response> deleteEventsHandler(Request request) async {
    String json = await request.readAsString();

    try {
      dynamic body = jsonDecode(json);
      String? id = body['id'];
      if (id != null) {
        String result = _eventsRepo.deleteEvent(id);
        return Response.ok(result);
      } else {
        return Response(400);
      }
    } catch (e) {
      return Response(400);
    }
  }

  Future<Response> joinEventsHandler(Request request) async {
    String json = await request.readAsString();

    try {
      dynamic body = jsonDecode(json);
      String? userId = body['userId'];
      String? eventId = body['eventId'];
      if (userId != null && eventId != null) {
        List<String>? result = await _eventsRepo.joinEventAsync(userId, eventId);
        if (result != null) {
          return Response.ok(jsonEncode(result));
        } else {
          return Response(400);
        }
      } else {
        return Response(400);
      }
    } catch (e) {
      return Response(400);
    }
  }

  Future<Response> unjoinEventsHandler(Request request) async {
    throw UnimplementedError();
  }
}
