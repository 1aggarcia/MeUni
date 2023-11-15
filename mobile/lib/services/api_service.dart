import 'package:http/http.dart';

class ApiService {
  String host = 'http://localhost:8080';
  String testUri = 'http://localhost:8080/events/get';

  Future<Response> getAsync(String url) async {
    final response = await get(Uri.parse(host + url));
    return response;
  }

  Future<Response> postAsync(String url, String? body) async {
    if (body == null) {
      return await post(Uri.parse(host + url));
    }
    return await post(Uri.parse(host + url), body: body);
  }

}
