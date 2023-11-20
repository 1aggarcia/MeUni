import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'dart:convert';

import '../models/event.dart';
import '../repository/events_repo.dart';
import 'controller.dart';

/// Only to be used within EventController or StudyGroupController
class EventTemplateController extends Controller {
  //* Private Properties
  final EventsRepo _eventsRepo;

  EventTemplateController(this._eventsRepo);

  //* Overriden Methods
  @override
  Router setUpRoutes(Router router, String endpoint) {
    return router
      ..get('$endpoint/get', getEventsHandler)
      ..post('$endpoint/create', postEventsHandler)
      ..post('$endpoint/delete', deleteEventsHandler)
      ..post('$endpoint/join', (request) => joinEventsHandler(request, true))
      ..post('$endpoint/unjoin', (request) => joinEventsHandler(request, false));
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
          throw Exception('Event was not found');
        }
      } catch (e) {
        return Response(400);
      }
    } else {
      List<Event> events = await _eventsRepo.getEventsAsync();
      return Response.ok(eventsToJson(events));
    }
  }

  // POST /
  Future<Response> postEventsHandler(Request request) async {
    String body = await request.readAsString();

    try {
      Event? event = eventFromJson(body);
      if (event != null) {
        String newId = await _eventsRepo.addEventAsync(event);
        return Response.ok(newId);
      } else {
        throw Exception('Json body could not be converted to event');
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
        String result = await _eventsRepo.deleteEventAsync(id);
        return Response.ok(result);
      } else {
        throw Exception("Missing param 'id'");
      }
    } catch (e) {
      return Response(400);
    }
  }

  /// joining = true indicates request to join,
  /// joining = false indicates request to unjoin
  Future<Response> joinEventsHandler(Request request, bool joining) async {
    String json = await request.readAsString();

    try {
      dynamic body = jsonDecode(json);
      String? userId = body['userId'];
      String? eventId = body['eventId'];
      if (userId != null && eventId != null) {
        List<String>? result;
        if (joining) {
          result = await _eventsRepo.joinEventAsync(userId, eventId);
        } else {
          result = await _eventsRepo.unjoinEventAsync(userId, eventId);
        }
        if (result != null) {
          return Response.ok(jsonEncode(result));
        } else {
          throw Exception("Event did not allow specified join operation");
        }
      } else {
        throw Exception("Missing one or more params, 'userId', 'eventId'");
      }
    } catch (e) {
      return Response(400);
    }
  }
}
