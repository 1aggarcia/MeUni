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
        return '/studygroups/get';
      case Endpoints.createStudyGroup:
        return '/studygroups/create';
      case Endpoints.deleteStudyGroup:
        return '/studygroups/delete';

      case Endpoints.joinStudyGroup:
        return '/studygroups/join';
      case Endpoints.unJoinStudyGroup:
        return '/studygroups/unjoin';

      default:
        throw UnimplementedError();
    }
  }
}

class ApiService {
  final _host = 'localhost:8080';

  Future<Response> getAsync(Endpoints endpoint,
      {Map<String, String>? params}) async {
    Uri url = Uri.http(_host, endpoint.uri, params);

    return await get(url);
  }

  Future<Response> postAsync(Endpoints endpoint,
      {Map<String, String>? params, String? body}) async {
    Uri url = Uri.http(_host, endpoint.uri, params);

    return await post(url, body: body);
  }
}
