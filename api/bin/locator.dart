import 'package:firebase_dart/database.dart';
import 'package:get_it/get_it.dart';

import 'repository/events_repo.dart';
import 'repository/mock/mock_events_repo.dart';
import 'repository/mock/mock_users_repo.dart';
import 'repository/users_repo.dart';

final locator = GetIt.instance;

final useMocks = false;

void setupLocator(DatabaseReference dbRef) {
  // Database
  locator.registerSingleton<DatabaseReference>(dbRef);

  if (useMocks) {
    locator.registerLazySingleton<EventsRepo>(MockEventsRepo.new);
    locator.registerLazySingleton<UsersRepo>(MockUsersRepo.new);
  } else {
    locator.registerLazySingleton<EventsRepo>(() => EventsRepoImpl('events'));
    locator.registerLazySingleton<UsersRepo>(MockUsersRepo.new);
  }
}
