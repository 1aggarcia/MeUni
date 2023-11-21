import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class EventDetailViewModel extends BaseViewModel {
  //* Private Properties
  final _navService = locator<NavigationService>();

  //* Public Properties
  final String eventId;

  //* Constructors
  EventDetailViewModel(this.eventId);

  //* Public Methods
  void goBack() => _navService.back();
}
