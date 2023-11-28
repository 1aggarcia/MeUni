// ignore_for_file: unused_import

import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../models/event.dart';
import '../models/study_group.dart';
import '../repository/i_events_repo.dart';
import '../repository/mock/mock_i_events_repo.dart';
import '../repository/mock/mock_users_repo.dart';
import '../repository/users_repo.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../ui/bottom_sheets/notice/notice_sheet.dart';
import '../ui/dialogs/info_alert/info_alert_dialog.dart';
import '../ui/views/create_event/create_event_view.dart';
import '../ui/views/create_profile/create_profile_view.dart';
import '../ui/views/create_study_group/create_study_group_view.dart';
import '../ui/views/event_detail/event_detail_view.dart';
import '../ui/views/events/events_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/profile/profile_view.dart';
import '../ui/views/startup/startup_view.dart';
import '../ui/views/study_group_detail/study_group_detail_view.dart';
import '../ui/views/study_groups/study_groups_view.dart';
import 'package:meuni_mobile/ui/views/classes/classes_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: CreateEventView),
    MaterialRoute(page: CreateProfileView),
    MaterialRoute(page: CreateStudyGroupView),
    MaterialRoute(page: EventsView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: StudyGroupsView),
    MaterialRoute(page: EventDetailView),
    MaterialRoute(page: StudyGroupDetailView),
    MaterialRoute(page: ClassesView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: ApiService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(
      classType: MockIEventsRepo<Event>,
      asType: IEventsRepo<Event>,
    ),
    LazySingleton(
      classType: MockIEventsRepo<StudyGroup>,
      asType: IEventsRepo<StudyGroup>,
    ),
    LazySingleton(classType: MockUsersRepo, asType: UsersRepo),
    LazySingleton(classType: NavigationService),
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
