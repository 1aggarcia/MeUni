import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

import 'controller.dart';
import '../models/article.dart';

class ArticleController extends Controller {
  //* Private Properties
  final List<Article> _articles = [];

  //* Overriden Methods
  @override
  Router setUpRoutes(Router router, String endpoint) {
    return router
      ..get(endpoint, getArticlesHandler)
      ..post(endpoint, postArticleHandler);
  }

  //* Public API Methods

  // GET /
  Response getArticlesHandler(Request request) {
    return Response.ok(articlesToJson(_articles));
  }

  // POST /
  Future<Response> postArticleHandler(Request request) async {
    String body = await request.readAsString();

    try {
      Article article = articleFromJson(body);
      _articles.add(article);
      return Response.ok(articleToJson(article));
    } catch (e) {
      return Response(400);
    }
  }
}
