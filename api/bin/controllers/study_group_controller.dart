import 'package:shelf_router/shelf_router.dart';

import '../repository/events_repo.dart';
import 'controller.dart';
import 'event_template.dart';

final _studyGroupsRepo = EventsRepoImpl('study_groups');

class StudyGroupController extends Controller {
  //* Private Properties
  final EventTemplateController _controller = EventTemplateController(_studyGroupsRepo);

  //* Overriden Methods
  @override
  Router setUpRoutes(Router router, String endpoint) {
    return _controller.setUpRoutes(router, endpoint);
  }
}