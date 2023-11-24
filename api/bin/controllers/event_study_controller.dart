import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/event.dart';
import '../repository/events_repo.dart';
import 'controller.dart';

/// Only to be used within EventController or StudyGroupController
class EventStudyController extends Controller {
  //* Private Properties
  final EventsRepo _eventsRepo;
  final String _paramName;

  EventStudyController(this._eventsRepo, this._paramName);

  //* Overriden Methods
  @override
  Router setUpRoutes(Router router, String endpoint) {
    return router
      ..get('$endpoint/get', getHandler)
      ..post('$endpoint/create', createHandler)
      ..post('$endpoint/delete', deleteHandler)
      ..post('$endpoint/join', joinHandler)
      ..post('$endpoint/unjoin', unjoinHandler);
  }

  //* Public API Methods

  // GET /
  /// No more than 1 parameter is allowed on a single request
  /// * if no params, returns list of all events
  /// * if 'id' param, returns event with given id or 404 if not found
  /// * if 'query' param, returns list of events sorted by relevance
  Future<Response> getHandler(Request request) async {
    Map<String, dynamic> params = request.url.queryParameters;

    if (params.containsKey('id') && params['id'] is String) {
      return getSingleEvent(params['id']);
    } else if (params.containsKey('query') && params['query'] is String) {
      return searchEvents(params['query']);
    } else {
      return getAllEvents();
    }
  }

  Future<Response> getSingleEvent(String id) async {
    try {
      Event? event = await _eventsRepo.getEventAsync(id);

      if (event != null) {
        return Response.ok(eventToJson(event));
      } else {
        return Response(404);
      }
    } catch (e) {
      return Response(400);
    }
  }

  Future<Response> searchEvents(String query) async {
    List<Event> events = await _eventsRepo.searchEventsAsync(query);
    return Response.ok(eventsToJson(events));
  }

  Future<Response> getAllEvents() async {
    List<Event> events = await _eventsRepo.getEventsAsync();
    return Response.ok(eventsToJson(events));
  }

  // POST /
  Future<Response> createHandler(Request request) async {
    String body = await request.readAsString();

    try {
      Event? event = eventFromJson(body);
      if (event != null) {
        event.attendees.clear(); // new events shouldn't have attendees
        String newId = await _eventsRepo.addEventAsync(event);
        return Response.ok(newId);
      } else {
        throw Exception('Json body could not be converted to event');
      }
    } catch (e) {
      return Response(400);
    }
  }

  Future<Response> deleteHandler(Request request) async {
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

  Future<Response> joinHandler(Request request) {
    return dualJoinHandler(request, true);
  }

  Future<Response> unjoinHandler(Request request) {
    return dualJoinHandler(request, false);
  }

  /// Handles both join and unjoin requests
  /// joining = true indicates request to join,
  /// joining = false indicates request to unjoin
  Future<Response> dualJoinHandler(Request request, bool joining) async {
    String json = await request.readAsString();

    try {
      dynamic body = jsonDecode(json);
      String? userId = body['userId'];
      String? eventId = body[_paramName];
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
          throw Exception('Event did not allow specified join operation');
        }
      } else {
        throw Exception("Missing one or more params, 'userId', '$_paramName'");
      }
    } catch (e) {
      return Response(400);
    }
  }
}
