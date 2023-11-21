import 'package:shelf_router/shelf_router.dart';

import '../repository/events_repo.dart';
import 'controller.dart';
import 'event_template.dart';

final _eventsRepo = EventsRepoImpl('events');

class EventController extends Controller {
  //* Private Properties
  final EventTemplateController _controller =
      EventTemplateController(_eventsRepo);

  //* Overriden Methods
  @override
  Router setUpRoutes(Router router, String endpoint) {
    return _controller.setUpRoutes(router, endpoint);
  }
}
