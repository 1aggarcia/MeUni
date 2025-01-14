import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../../../models/event.dart';
import '../../../../models/i_event.dart';
import '../../../../repository/i_events_repo.dart';
import '../../../../services/auth_service.dart';
import '../../../common/app_colors.dart';
import '../../../views/home/home_viewmodel.dart';

class IEventDetailViewModel<T extends IEvent> extends FutureViewModel {
  //* Private Properties
  final _authService = locator<AuthService>();
  final _dialogService = locator<DialogService>();
  final _navService = locator<NavigationService>();

  final _iEventsRepo = locator<IEventsRepo<T>>();

  final String _label = T == Event ? 'Event' : 'Study Group';

  //* Public Properties
  final String iEventId;

  bool get isUserHost => iEvent.hostId == _authService.currUser.id;
  bool get canUnJoin => iEvent.attendees.contains(_authService.currUser.id);

  late final IEvent iEvent;

  //* Constructors
  IEventDetailViewModel(this.iEventId);

  //* Overridden Methods
  @override
  Future futureToRun() => getIEventAsync();

  //* Public Methods
  Future<void> getIEventAsync() async {
    var result = await _iEventsRepo.getIEventAsync(iEventId);
    if (result == null) {
      await _dialogService.showDialog(
        title: 'Error!',
        description: 'Please try again another time.',
      );

      await _goBackAsync();
    } else {
      iEvent = result;
    }
  }

  Future<void> deleteIEventAsync() async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure you want to delete this $_label?',
      description: 'This action cannot be undone',
      confirmationTitleColor: kcTextErrorColor,
      confirmationTitle: 'Delete',
      cancelTitle: 'Go back',
      cancelTitleColor: kcPrimaryColor,
    );

    if (dialogResponse != null && dialogResponse.confirmed) {
      bool deleteSuccess =
          await runBusyFuture(_iEventsRepo.deleteIEventAsync(iEventId));

      if (deleteSuccess) {
        await _dialogService.showDialog(
          title: 'Success!',
          description: 'Successfully deleted.',
        );
      } else {
        await _dialogService.showDialog(
          title: 'Failed!',
          description: 'There was an error deleting the $_label.',
        );
      }

      await _goBackAsync();
    }
  }

  Future<void> joinIEventAsync() async {
    var joinSuccess =
        await runBusyFuture(_iEventsRepo.joinIEventAsync(iEventId));

    if (joinSuccess) {
      await _dialogService.showDialog(
        title: 'Success!',
        description: 'Successfully joined.',
      );
    } else {
      await _dialogService.showDialog(
        title: 'Failed!',
        description:
            'There was an error joining the $_label. The $_label may be full.',
      );
    }

    await _goBackAsync();
  }

  Future<void> unJoinIEventAsync() async {
    bool unJoinSuccess =
        await runBusyFuture(_iEventsRepo.unJoinIEventAsync(iEventId));

    if (unJoinSuccess) {
      await _dialogService.showDialog(
        title: 'Success!',
        description: 'Successfully left.',
      );
    } else {
      await _dialogService.showDialog(
        title: 'Failed!',
        description:
            'There was an error leaving the $_label. The $_label may be full.',
      );
    }

    await _goBackAsync();
  }

  //* Private Methods
  Future<void> _goBackAsync() async {
    await _navService.clearStackAndShow(
      Routes.homeView,
      arguments: HomeViewArguments(
        initialView: T == Event ? NavView.events : NavView.studyGroups,
      ),
    );
  }
}
