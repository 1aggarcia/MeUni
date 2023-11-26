import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../models/i_event.dart';
import '../../../../repository/i_events_repo.dart';
import '../../../../services/auth_service.dart';

class IEventDetailViewModel<T extends IEvent> extends BaseViewModel {
  //* Private Properties
  final _authService = locator<AuthService>();
  final _dialogService = locator<DialogService>();
  final _navService = locator<NavigationService>();

  final _iEventsRepo = locator<IEventsRepo<T>>();

  //* Public Properties
  final String iEventId;

  bool get isUserHost => iEvent.hostId == _authService.currUser.id;
  bool get canUnJoin => iEvent.attendees.contains(_authService.currUser.id);

  late final IEvent iEvent;

  //* Constructors
  IEventDetailViewModel(this.iEventId) {
    setBusy(true);
  }

  //* Public Methods
  Future<void> getIEventAsync() async {
    var result = await _iEventsRepo.getIEventAsync(iEventId);
    if (result == null) {
      await _dialogService.showDialog(
        title: 'Error!',
        description: 'Please try again another time.',
      );

      _navService.back();
    } else {
      iEvent = result;

      setBusy(false);
    }
  }

  Future<void> joinIEventAsync() async {
    await runBusyFuture(_iEventsRepo.joinIEventAsync(iEventId));

    await _dialogService.showDialog(
      title: 'Success!',
      description: 'Successfully joined.',
    );

    _navService.back();
  }

  Future<void> unJoinIEventAsync() async {
    await runBusyFuture(_iEventsRepo.unJoinIEventAsync(iEventId));

    await _dialogService.showDialog(
      title: 'Success!',
      description: 'Successfully left.',
    );

    _navService.back();
  }
}
