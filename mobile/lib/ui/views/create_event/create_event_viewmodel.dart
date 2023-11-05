import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../repository/events_repo.dart';

class CreateEventViewModel extends BaseViewModel {
  //* Private Properties
  final _eventsRepo = locator<EventsRepo>();

  final _navigationService = locator<NavigationService>();

  //* Public Methods
  void goToPrevPage() {
    _navigationService.back();
  }
}
