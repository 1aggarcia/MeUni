import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../repository/users_repo.dart';
import '../../../services/auth_service.dart';
import '../home/home_viewmodel.dart';
import 'classes_view.form.dart';

class ClassesViewModel extends FormViewModel {
  //* Private Properties
  final _usersRepo = locator<UsersRepo>();

  final _authService = locator<AuthService>();
  final _navService = locator<NavigationService>();

  //* Public Methods
  Future<void> addClassAsync() async {
    if (isFormValid) {
      await runBusyFuture(
        _usersRepo.addUserClassAsync(
          id: _authService.currUser.id,
          className: '${prefixValue!} ${courseCodeValue!}',
        ),
      );
    }

    await _navService.clearStackAndShow(
      Routes.homeView,
      arguments: const HomeViewArguments(initialView: NavView.Profile),
    );
  }
}

class ClassValidators {
  //* Public Methods
  static String? validateCourseCode(String? value) {
    if (value == null) {
      return null;
    }

    int? courseCode = int.tryParse(value);

    if (courseCode == null) {
      return 'Only numbers allowed';
    } else if (courseCode < 100 || courseCode > 699) {
      return 'courseCode must be from 100-699';
    }

    return null;
  }
}
