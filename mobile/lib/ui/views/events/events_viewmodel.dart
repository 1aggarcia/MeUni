import 'package:meuni_mobile/app/app.locator.dart';
import 'package:meuni_mobile/repository/events_repo.dart';
import 'package:stacked/stacked.dart';

import '../../../models/event.dart';

class EventsViewModel extends BaseViewModel {
  final _eventsRepo = locator<EventsRepo>();

  List<Event> events = [];

  Future getEventsAsync() async {
    events = await _eventsRepo.getEventsAsync();
    rebuildUi();
  }
}
