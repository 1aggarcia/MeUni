import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/auth_service.dart';

class LoginViewModel extends BaseViewModel {
  //* Private Properties
  final _authService = locator<AuthService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  //* Public Methods
  Future<void> signInWithGoogleAsync() async {
    setBusy(true);

    if (!(await _authService.loginAsync())) {
      // Login Failed
      await _dialogService.showDialog(
        title: 'Error!',
        description: 'Please try again another time.',
      );
    } else {
      if (_authService.isLoggedIn) {
        await _navigationService.replaceWithHomeView();
      } else {
        await _navigationService.replaceWithCreateProfileView();
      }
    }

    setBusy(false);
  }
}
