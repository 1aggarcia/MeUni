import 'package:shelf_router/shelf_router.dart';

abstract class Controller {
  //* Set up routes for this controller class
  Router setUpRoutes(Router router, String endpoint);
}
