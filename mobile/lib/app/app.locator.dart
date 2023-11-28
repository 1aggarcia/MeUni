// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../repository/i_events_repo.dart';
import '../repository/mock/mock_i_events_repo.dart';
import '../repository/mock/mock_users_repo.dart';
import '../repository/users_repo.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton<IEventsRepo<Event>>(
      () => MockIEventsRepo<Event>());
  locator.registerLazySingleton<IEventsRepo<StudyGroup>>(
      () => MockIEventsRepo<StudyGroup>());
  locator.registerLazySingleton<UsersRepo>(() => MockUsersRepo());
  locator.registerLazySingleton(() => NavigationService());
}
