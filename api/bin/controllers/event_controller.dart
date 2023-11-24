import 'package:shelf_router/shelf_router.dart';

import '../repository/events_repo.dart';
import 'controller.dart';
import 'event_study_controller.dart';

// may want to consider a generic name for this param
final paramName = 'eventId';
final _eventsRepo = EventsRepoImpl('events', paramName);

class EventController extends Controller {
  //* Private Properties
  final EventStudyController _controller =
      EventStudyController(_eventsRepo, paramName);

  //* Overriden Methods
  @override
  Router setUpRoutes(Router router, String endpoint) {
    return _controller.setUpRoutes(router, endpoint);
  }
}
