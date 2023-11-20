import 'package:meuni_mobile/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/user.dart';
import '../../../repository/users_repo.dart';
import 'create_profile_view.form.dart';

class CreateProfileViewModel extends FormViewModel {
  //* Properties
  final _usersRepo = locator<UsersRepo>();
  final _navigationService = locator<NavigationService>();

  final String userId;

  //* Constructors
  CreateProfileViewModel({required this.userId});

  //* Public Methods
  Future createProfileAsync() async {
    if (isFormValid) {
      setBusy(true);

      User user = await _usersRepo.addUserAsync(
        id: userId,
        firstName: firstNameValue!,
        lastName: lastNameValue!,
        year: int.parse(yearValue!),
        pronouns: pronounsValue!,
      );

      _usersRepo.loggedInUser = user;

      setBusy(false);

      _navigationService.replaceWithHomeView();
    }
  }
}

class CreateProfileValidators {
  static String? validateYear(String? value) {
    if (value == null) {
      return null;
    }

    int? year = int.tryParse(value);

    if (year == null) {
      return 'Only numbers allowed';
    } else if (year <= 0 || year > 4) {
      return 'Year must be from 1 to 4.';
    }

    return null;
  }
}
