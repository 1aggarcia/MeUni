// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i13;
import 'package:flutter/material.dart';
import 'package:meuni_mobile/ui/views/create_event/create_event_view.dart'
    as _i2;
import 'package:meuni_mobile/ui/views/create_profile/create_profile_view.dart'
    as _i3;
import 'package:meuni_mobile/ui/views/create_study_group/create_study_group_view.dart'
    as _i4;
import 'package:meuni_mobile/ui/views/event_detail/event_detail_view.dart'
    as _i11;
import 'package:meuni_mobile/ui/views/events/events_view.dart' as _i5;
import 'package:meuni_mobile/ui/views/home/home_view.dart' as _i6;
import 'package:meuni_mobile/ui/views/login/login_view.dart' as _i7;
import 'package:meuni_mobile/ui/views/profile/profile_view.dart' as _i8;
import 'package:meuni_mobile/ui/views/startup/startup_view.dart' as _i9;
import 'package:meuni_mobile/ui/views/study_group_detail/study_group_detail_view.dart'
    as _i12;
import 'package:meuni_mobile/ui/views/study_groups/study_groups_view.dart'
    as _i10;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i14;

class Routes {
  static const createEventView = '/create-event-view';

  static const createProfileView = '/create-profile-view';

  static const createStudyGroupView = '/create-study-group-view';

  static const eventsView = '/events-view';

  static const homeView = '/home-view';

  static const loginView = '/login-view';

  static const profileView = '/profile-view';

  static const startupView = '/startup-view';

  static const studyGroupsView = '/study-groups-view';

  static const eventDetailView = '/event-detail-view';

  static const studyGroupDetailView = '/study-group-detail-view';

  static const all = <String>{
    createEventView,
    createProfileView,
    createStudyGroupView,
    eventsView,
    homeView,
    loginView,
    profileView,
    startupView,
    studyGroupsView,
    eventDetailView,
    studyGroupDetailView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.createEventView,
      page: _i2.CreateEventView,
    ),
    _i1.RouteDef(
      Routes.createProfileView,
      page: _i3.CreateProfileView,
    ),
    _i1.RouteDef(
      Routes.createStudyGroupView,
      page: _i4.CreateStudyGroupView,
    ),
    _i1.RouteDef(
      Routes.eventsView,
      page: _i5.EventsView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i6.HomeView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i7.LoginView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i8.ProfileView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i9.StartupView,
    ),
    _i1.RouteDef(
      Routes.studyGroupsView,
      page: _i10.StudyGroupsView,
    ),
    _i1.RouteDef(
      Routes.eventDetailView,
      page: _i11.EventDetailView,
    ),
    _i1.RouteDef(
      Routes.studyGroupDetailView,
      page: _i12.StudyGroupDetailView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.CreateEventView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.CreateEventView(),
        settings: data,
      );
    },
    _i3.CreateProfileView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.CreateProfileView(),
        settings: data,
      );
    },
    _i4.CreateStudyGroupView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.CreateStudyGroupView(),
        settings: data,
      );
    },
    _i5.EventsView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.EventsView(),
        settings: data,
      );
    },
    _i6.HomeView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.HomeView(),
        settings: data,
      );
    },
    _i7.LoginView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.LoginView(),
        settings: data,
      );
    },
    _i8.ProfileView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.ProfileView(),
        settings: data,
      );
    },
    _i9.StartupView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.StartupView(),
        settings: data,
      );
    },
    _i10.StudyGroupsView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.StudyGroupsView(),
        settings: data,
      );
    },
    _i11.EventDetailView: (data) {
      final args = data.getArgs<EventDetailViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i11.EventDetailView(key: args.key, eventId: args.eventId),
        settings: data,
      );
    },
    _i12.StudyGroupDetailView: (data) {
      final args = data.getArgs<StudyGroupDetailViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.StudyGroupDetailView(
            key: args.key, studyGroupId: args.studyGroupId),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class EventDetailViewArguments {
  const EventDetailViewArguments({
    this.key,
    required this.eventId,
  });

  final _i13.Key? key;

  final String eventId;

  @override
  String toString() {
    return '{"key": "$key", "eventId": "$eventId"}';
  }

  @override
  bool operator ==(covariant EventDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.eventId == eventId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ eventId.hashCode;
  }
}

class StudyGroupDetailViewArguments {
  const StudyGroupDetailViewArguments({
    this.key,
    required this.studyGroupId,
  });

  final _i13.Key? key;

  final String studyGroupId;

  @override
  String toString() {
    return '{"key": "$key", "studyGroupId": "$studyGroupId"}';
  }

  @override
  bool operator ==(covariant StudyGroupDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.studyGroupId == studyGroupId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ studyGroupId.hashCode;
  }
}

extension NavigatorStateExtension on _i14.NavigationService {
  Future<dynamic> navigateToCreateEventView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.createEventView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.createProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateStudyGroupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.createStudyGroupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEventsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.eventsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStudyGroupsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.studyGroupsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEventDetailView({
    _i13.Key? key,
    required String eventId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.eventDetailView,
        arguments: EventDetailViewArguments(key: key, eventId: eventId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStudyGroupDetailView({
    _i13.Key? key,
    required String studyGroupId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.studyGroupDetailView,
        arguments:
            StudyGroupDetailViewArguments(key: key, studyGroupId: studyGroupId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateEventView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.createEventView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.createProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateStudyGroupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.createStudyGroupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEventsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.eventsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStudyGroupsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.studyGroupsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEventDetailView({
    _i13.Key? key,
    required String eventId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.eventDetailView,
        arguments: EventDetailViewArguments(key: key, eventId: eventId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStudyGroupDetailView({
    _i13.Key? key,
    required String studyGroupId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.studyGroupDetailView,
        arguments:
            StudyGroupDetailViewArguments(key: key, studyGroupId: studyGroupId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
