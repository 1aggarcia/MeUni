import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/user.dart';
import '../../../repository/users_repo.dart';
import './login_view.form.dart';

class LoginViewModel extends FormViewModel {
  //* Private Properties
  final _userRepo = locator<UsersRepo>();

  final _navigationService = locator<NavigationService>();

  //* Public Properties
  bool isLoading = false;

  //* Public Methods
  Future loginUser() async {
    if (isFormValid) {
      isLoading = true;
      rebuildUi();

      String id = '';
      String userName = usernameValue!;
      if (userName == 'Fei') {
        id = '1';
      } else if (usernameValue == 'John') {
        id = '2';
      }

      User user = await _userRepo.getUserAsync(id);
      _userRepo.loggedInUser = user;

      isLoading = false;
      _navigationService.replaceWithHomeView();
    }
  }
}

class LoginValidators {
  static String? validateUsername(String? username) {
    if (username == null) {
      return null;
    }

    if (username.isEmpty) {
      return 'Username not recognized';
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null) {
      return null;
    }

    if (password.isEmpty) {
      return 'Incorrect Password';
    }

    return null;
  }
}
