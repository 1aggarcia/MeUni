import 'package:meuni_mobile/app/app.router.dart';
import 'package:meuni_mobile/repository/users_repo.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import 'package:meuni_mobile/ui/views/login/login_view.form.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/user.dart';


class LoginViewModel extends FormViewModel {

  final _userRepo = locator<UsersRepo>();

  final _navigationService = locator<NavigationService>();

  //* Public Properties
  bool isLoading = false;

  //* Public Methods
  Future loginUser() async {
    if (isFormValid && usernameValue != null && passwordValue != null) {
      isLoading = true;
      rebuildUi();
      int id = 0;
      String userName = usernameValue ?? '';
      if (userName == 'Fei') {
        id = 1;
      } else if (usernameValue == 'John') {
        id = 2;
      } else {
        return null;
      }
      User user = await _userRepo.getUserAsync(id);
      _userRepo.loggedInUser = user;

      isLoading = false;
      _navigationService.replaceWithEventsView();
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
