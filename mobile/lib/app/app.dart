import 'package:meuni_mobile/repository/events_repo.dart';
import 'package:meuni_mobile/repository/mock/mock_events_repo.dart';
import 'package:meuni_mobile/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:meuni_mobile/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:meuni_mobile/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:meuni_mobile/ui/views/events/events_view.dart';
import 'package:meuni_mobile/ui/views/create_event/create_event_view.dart';
import 'package:meuni_mobile/ui/views/login/login_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: EventsView),
    MaterialRoute(page: CreateEventView),
    MaterialRoute(page: LoginView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: MockEventsRepo, asType: EventsRepo)
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
class App {}
