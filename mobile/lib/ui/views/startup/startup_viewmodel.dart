import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';

class StartupViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();

  // Place anything here that needs to happen before we get into the application
  Future<void> runStartupLogic() async {
    await Future.delayed(App.demoDuration);

    await _navService.replaceWithLoginView();
  }
}
