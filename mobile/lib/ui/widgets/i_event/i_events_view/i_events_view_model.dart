import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../../../models/event.dart';
import '../../../../models/i_event.dart';
import '../../../../repository/i_events_repo.dart';
import 'i_events_view.form.dart';

class IEventsViewModel<T extends IEvent> extends FormViewModel {
  //* Private Properties
  final _eventsRepo = locator<IEventsRepo<T>>();

  final _navService = locator<NavigationService>();

  //* Public Properties
  List<IEvent> iEvents = [];

  //* Public Methods
  Future<void> getIEventsAsync() async {
    iEvents = await runBusyFuture(
      _eventsRepo.getIEventsAsync(
        searchQuery: T == Event ? searchEventValue : searchStudyGroupValue,
      ),
      busyObject: iEvents,
    );
  }

  Future<void> goToCreateIEventPageAsync() async {
    if (T == Event) {
      await _navService.navigateToCreateEventView();
    } else {
      await _navService.navigateToCreateStudyGroupView();
    }
  }

  Future<void> goToIEventDetailPageAsync(int index) async {
    if (T == Event) {
      await _navService.navigateToEventDetailView(
        eventId: iEvents[index].id,
      );
    } else {
      await _navService.navigateToStudyGroupDetailView(
        studyGroupId: iEvents[index].id,
      );
    }
  }
}
