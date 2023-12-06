import 'package:http/http.dart';

enum Endpoints {
  //* Enums
  getUser,
  createUser,
  updateUser,

  getUserClasses,
  createUserClass,
  deleteUserClass,

  getEvents,
  createEvent,
  deleteEvent,

  joinEvent,
  unJoinEvent,

  getStudyGroups,
  createStudyGroup,
  deleteStudyGroup,

  joinStudyGroup,
  unJoinStudyGroup;

  //* Get URI from Enum
  String get uri {
    switch (this) {
      case Endpoints.getUser:
        return '/user/profile/get';
      case Endpoints.createUser:
        return '/user/profile/create';
      case Endpoints.updateUser:
        return '/user/profile/update';

      case Endpoints.getUserClasses:
        return '/user/courses/get';
      case Endpoints.createUserClass:
        return '/user/courses/add';
      case Endpoints.deleteUserClass:
        return '/user/courses/remove';

      case Endpoints.getEvents:
        return '/events/get';
      case Endpoints.createEvent:
        return '/events/create';
      case Endpoints.deleteEvent:
        return '/events/delete';

      case Endpoints.joinEvent:
        return '/events/join';
      case Endpoints.unJoinEvent:
        return '/events/unjoin';

      case Endpoints.getStudyGroups:
        return '/study_groups/get';
      case Endpoints.createStudyGroup:
        return '/study_groups/create';
      case Endpoints.deleteStudyGroup:
        return '/study_groups/delete';

      case Endpoints.joinStudyGroup:
        return '/study_groups/join';
      case Endpoints.unJoinStudyGroup:
        return '/study_groups/unjoin';

      default:
        throw UnimplementedError();
    }
  }
}

/// Responsible for communicating with the API to fetch data
class ApiService {
  final _host = 'api-ayyljr3w6a-uw.a.run.app';

  /// Sends a GET request to the API based on the given [endpoint],
  /// adding on [params] to the URL if provided
  Future<Response> getAsync(Endpoints endpoint,
      {Map<String, String>? params}) async {
    Uri url = Uri.https(_host, endpoint.uri, params);

    return await get(url);
  }

  /// Sends a POST request to the API based on the given [endpoint],
  /// adding on [params] to the URL if provided. Provide [body] to send JSON
  /// to the server via the POST call's body.
  Future<Response> postAsync(Endpoints endpoint,
      {Map<String, String>? params, String? body}) async {
    Uri url = Uri.https(_host, endpoint.uri, params);

    return await post(url, body: body);
  }
}

bool responseOk(Response response) => response.statusCode == 200;
