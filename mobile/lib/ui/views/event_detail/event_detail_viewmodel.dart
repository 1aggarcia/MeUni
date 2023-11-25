import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/event.dart';
import '../../../repository/i_events_repo.dart';
import '../../../services/auth_service.dart';

class EventDetailViewModel extends BaseViewModel {
  //* Private Properties
  final _authService = locator<AuthService>();
  final _dialogService = locator<DialogService>();
  final _navService = locator<NavigationService>();

  final _eventsRepo = locator<IEventsRepo<Event>>();

  //* Public Properties
  final String eventId;

  bool get isUserHost => event.hostId == _authService.currUser.id;
  bool get canUnJoin => event.attendees.contains(_authService.currUser.id);

  late final Event event;

  //* Constructors
  EventDetailViewModel(this.eventId) {
    setBusy(true);
  }

  //* Public Methods
  void goBack() => _navService.back();

  Future<void> getEventAsync() async {
    var result = await _eventsRepo.getIEventAsync(eventId);
    if (result == null) {
      await _dialogService.showDialog(
        title: 'Error!',
        description: 'Please try again another time.',
      );

      goBack();
    } else {
      event = result as Event;

      setBusy(false);
    }
  }

  Future<void> joinEventAsync() async =>
      await _eventsRepo.joinIEventAsync(eventId);

  Future<void> unJoinEventAsync() async =>
      await _eventsRepo.unJoinIEventAsync(eventId);
}
