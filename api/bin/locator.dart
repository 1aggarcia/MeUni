import 'package:get_it/get_it.dart';

import 'repository/events_repo.dart';
import 'repository/mock/mock_events_repo.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<EventsRepo>(() => MockEventsRepo());
}
