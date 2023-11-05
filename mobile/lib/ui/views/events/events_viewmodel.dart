import 'package:meuni_mobile/app/app.locator.dart';
import 'package:meuni_mobile/repository/events_repo.dart';
import 'package:stacked/stacked.dart';

import '../../../models/event.dart';

class EventsViewModel extends BaseViewModel {
  //* Private Properties
  final _eventsRepo = locator<EventsRepo>();

  //* Public Properties
  bool isLoading = false;

  List<Event> events = [];

  Future getEventsAsync() async {
    isLoading = true;
    rebuildUi();

    events = await _eventsRepo.getEventsAsync();
    isLoading = false;
    rebuildUi();
  }
}
