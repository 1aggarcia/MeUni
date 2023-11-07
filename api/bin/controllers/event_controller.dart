import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

import 'controller.dart';
import '../models/event.dart';
import 'mock_events.dart';

class EventController extends Controller {
  //* Private Properties
  // _events must be sorted in order of increasing id
  final List<Event> _events = MockEventsRepo().getMockEvents();
  int availableId = MockEventsRepo().getMockEvents().last.id + 1;

  //* Overriden Methods
  @override
  Router setUpRoutes(Router router, String endpoint) {
    String getEndpoint = "$endpoint/get";
    String createEndpoint = "$endpoint/create";
    return router
      ..get(getEndpoint, getEventsHandler)
      ..post(createEndpoint, postEventsHandler);
  }

  //* Public API Methods

  // GET /
  /// Optional id parameter
  /// Returns event with given id or list of all events, if param not included
  Response getEventsHandler(Request request) {
    Map<String, dynamic> params = request.url.queryParameters;

    if (params.containsKey('id')) {
      try {
        int eventId = int.parse(params['id']);
        dynamic event = findEvent(eventId);
        if (event is Event) {
          return Response.ok(eventToJson(event));
        } else {
          return Response(400);
        }
      } catch (e) {
        print("Failed to get event: $e");
        return Response(400);
      }
    } else {
      return Response.ok(eventsToJson(_events));
    }
  }

  // POST /
  Future<Response> postEventsHandler(Request request) async {
    String body = await request.readAsString();

    try {
      Event event = eventFromJson(body, availableId);
      _events.add(event);
      availableId++;
      return Response.ok(eventToJson(event));
    } catch (e) {
      return Response(400);
    }
  }
  /// Return the event with given eventId, if it exists
  /// @param eventId of event
  /// @returns event if found, false otherwise
  dynamic findEvent(int eventId) {
    int i = 0;
    Event e = _events[i];
    // _events will be exausted or desired event found
    while (i < _events.length && e.id != eventId) {
      e = _events[i];
      i++;
    }

    if (e.id == eventId) {
      return e;
    } else {
      return false;
    }
  }

  List<Event> getEvents() {
    return _events;
  }

  int getAvaliableId() {
    return availableId;
  }
}
