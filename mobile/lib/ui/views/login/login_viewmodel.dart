import 'package:meuni_mobile/app/app.router.dart';
import 'package:meuni_mobile/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class LoginViewModel extends BaseViewModel {
  //* Private Properties
  final _authService = locator<AuthService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  //* Public Methods
  Future signInWithGoogleAsync() async {
    if (!(await _authService.loginAsync())) {
      // Login Failed
      _dialogService.showDialog(
        title: 'Error!',
        description: 'Please try again another time.',
      );
    } else {
      if (_authService.isLoggedIn) {
        _navigationService.replaceWithHomeView();
      } else {
        _navigationService.replaceWithCreateProfileView();
      }
    }
  }
}
