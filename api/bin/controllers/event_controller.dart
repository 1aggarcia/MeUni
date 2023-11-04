import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

import 'controller.dart';
import '../models/event.dart';

class EventController extends Controller {
  //* Private Properties
  final List<Event> _events = [];

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
    return Response.ok(articlesToJson(_events));
  }

  // POST /
  Future<Response> postEventsHandler(Request request) async {
    String body = await request.readAsString();

    try {
      Event event = eventFromJson(body);
      print(event.title);
      _events.add(event);
      return Response.ok(eventToJson(event));
    } catch (e) {
      print('oh no');
      return Response(400);
    }
  }
}
