import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/auth_service.dart';
import 'create_profile_view.form.dart';

class CreateProfileViewModel extends FormViewModel {
  //* Properties
  final _authService = locator<AuthService>();
  final _navService = locator<NavigationService>();

  //* Public Methods
  Future createProfileAsync() async {
    if (isFormValid) {
      await runBusyFuture(_authService.signupAsync(
        firstNameValue!,
        lastNameValue!,
        int.parse(yearValue!),
        pronounsValue!,
      ));

      await _navService.replaceWithHomeView();
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
