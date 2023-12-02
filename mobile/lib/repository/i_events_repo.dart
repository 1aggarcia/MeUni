import 'dart:convert';

import 'package:http/http.dart';

import '../app/app.locator.dart';
import '../models/event.dart';
import '../models/i_event.dart';
import '../models/study_group.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

abstract class IEventsRepo<T extends IEvent> {
  //* Public Methods
  Future<IEvent?> getIEventAsync(String id);
  Future<List<IEvent>> getIEventsAsync({String? searchQuery});

  Future<bool> addIEventAsync({
    required String title,
    required String desc,
    required String location,
    required int max,
    required DateTime startTime,
    required DateTime endTime,
  });

  Future<bool> joinIEventAsync(String id);
  Future<bool> unJoinIEventAsync(String id);
}

class IEventsRepoImpl<T extends IEvent> extends IEventsRepo<T> {
  //* Private Properties
  final _apiService = locator<ApiService>();
  final _authService = locator<AuthService>();

  //* Overridden Methods
  @override
  Future<IEvent?> getIEventAsync(String id) async {
    var response = await _apiService.getAsync(
      T == Event ? Endpoints.getEvents : Endpoints.getStudyGroups,
      params: {'id': id},
    );

    if (!responseOk(response)) {
      return null;
    }

    return _iEventFromJson(response.body);
  }

  @override
  Future<List<IEvent>> getIEventsAsync({String? searchQuery}) async {
    Response response = await _apiService.getAsync(
      T == Event ? Endpoints.getEvents : Endpoints.getStudyGroups,
      params: searchQuery == null ? null : {'query': searchQuery},
    );

    if (!responseOk(response)) {
      return [];
    }

    return _iEventsFromJson(response.body);
  }

  @override
  Future<bool> addIEventAsync({
    required String title,
    required String desc,
    required String location,
    required int max,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    // Create the IEvent
    IEvent iEvent;
    if (T == Event) {
      iEvent = Event(
        id: '-1', // API creates an ID for us
        title: title,
        desc: desc,
        location: location,
        max: max,
        startTime: startTime,
        endTime: endTime,
        hostId: _authService.currUser.id,
        hostName: '[TEMP]', // API pulls this from hostId
        attendees: [],
      );
    } else {
      iEvent = StudyGroup(
        id: '-1', // API creates an ID for us
        course: title,
        desc: desc,
        location: location,
        max: max,
        startTime: startTime,
        endTime: endTime,
        hostId: _authService.currUser.id,
        hostName: '[TEMP]', // API pulls this from hostId
        attendees: [],
      );
    }

    var response = await _apiService.postAsync(
      T == Event ? Endpoints.createEvent : Endpoints.createStudyGroup,
      body: _iEventToJson(iEvent),
    );

    return responseOk(response);
  }

  @override
  Future<bool> joinIEventAsync(String id) async {
    var jsonBody = {
      'userId': _authService.currUser.id,
    };
    if (T == Event) {
      jsonBody['eventId'] = id;
    } else {
      jsonBody['studyGroupId'] = id;
    }

    var response = await _apiService.postAsync(
      T == Event ? Endpoints.joinEvent : Endpoints.joinStudyGroup,
      body: jsonEncode(jsonBody),
    );

    return responseOk(response);
  }

  @override
  Future<bool> unJoinIEventAsync(String id) async {
    var jsonBody = {
      'userId': _authService.currUser.id,
    };
    if (T == Event) {
      jsonBody['eventId'] = id;
    } else {
      jsonBody['studyGroupId'] = id;
    }

    var response = await _apiService.postAsync(
      T == Event ? Endpoints.unJoinEvent : Endpoints.unJoinStudyGroup,
      body: jsonEncode(jsonBody),
    );

    return responseOk(response);
  }

  //* Private Methods
  String _iEventToJson(IEvent iEvent) => jsonEncode(iEvent.toJson());

  IEvent _iEventFromJson(String json) {
    if (T == Event) {
      return Event.fromJson(jsonDecode(json));
    } else {
      return StudyGroup.fromJson(jsonDecode(json));
    }
  }

  List<IEvent> _iEventsFromJson(String json) {
    var result = jsonDecode(json).map((x) {
      if (T == Event) {
        return Event.fromJson(x);
      } else {
        return StudyGroup.fromJson(x);
      }
    });

    // ignore: unnecessary_lambdas
    return List<IEvent>.from(result);
  }
}
