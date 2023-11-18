// ignore_for_file: unused_import

import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../repository/events_repo.dart';
import '../repository/mock/mock_events_repo.dart';
import '../repository/mock/mock_users_repo.dart';
import '../repository/mock/mock_studygroups_repo.dart';
import '../repository/users_repo.dart';
import '../repository/studygroup_repo.dart';

import '../services/api_service.dart';

import '../ui/bottom_sheets/notice/notice_sheet.dart';
import '../ui/dialogs/info_alert/info_alert_dialog.dart';

import '../ui/views/create_event/create_event_view.dart';
import '../ui/views/create_studygroup/create_studygroup_view.dart';
import '../ui/views/events/events_view.dart';
import '../ui/views/studygroup/studygroup_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/startup/startup_view.dart';
import 'package:meuni_mobile/ui/views/profile/profile_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: EventsView),
    MaterialRoute(page: CreateEventView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: StudyGroupView),
    MaterialRoute(page: CreateStudyGroupView),
    MaterialRoute(page: ProfileView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: MockEventsRepo, asType: EventsRepo),
    LazySingleton(classType: MockUsersRepo, asType: UsersRepo),
    LazySingleton(classType: MockStudyGroupRepo, asType: StudyGroupRepo),
    // LazySingleton(classType: MockEventsRepo, asType: EventsRepo),
    // LazySingleton(classType: MockUsersRepo, asType: UsersRepo),
    LazySingleton(classType: ApiService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {
  static const demoDuration = Duration(seconds: 0);
}
