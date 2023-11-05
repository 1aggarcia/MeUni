import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

import 'controller.dart';
import '../models/event.dart';
import 'mock_events.dart';

class EventController extends Controller {
  //* Private Properties
  final List<Event> _events = MockEventsRepo().getMockEvents();
  int availableId = 0;

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
  Response getEventsHandler(Request request) {
    return Response.ok(eventsToJson(_events));

// Code to get specific event by Id, probably not needed
    // String body = await request.readAsString();

    // try {
    //   Map<String, dynamic> decode= json.decode(body);
    //   int eventId = decode['id'];
    //   dynamic event = findEvent(eventId);
    //   if (event is Event) {
    //     return Response.ok(eventToJson(event));
    //   } else {
    //     return Response(400);
    //   }
    // } catch (e) {
    //   print("Failed to get event");
    //   return Response(400);
    // }
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
}

// Helper function for get request by Id
//   /// Return the event with given eventId, if it exists
//   /// @param eventId of event
//   /// @returns event if found, false otherwise
//   dynamic findEvent(int eventId) {
//     int i = 0;
//     Event e = _events[i];
//     // _events will be exausted or desired event found
//     while (i < _events.length && e.id != eventId) {
//       i++;
//       e = _events[i];
//     }

//     if (e.id == eventId) {
//       return e;
//     } else {
//       return false;
//     }
//   }
