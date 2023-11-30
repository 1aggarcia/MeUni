import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/user.dart';
import '../../../repository/users_repo.dart';
import '../../../services/auth_service.dart';

class ProfileViewModel extends BaseViewModel {
  //* Private Properties
  final _usersRepo = locator<UsersRepo>();

  final _authService = locator<AuthService>();

  final _navigationService = locator<NavigationService>();

  //* Public Properties
  List<String> classes = [];
  late final User user;

  //* Constructors
  ProfileViewModel() {
    user = _authService.currUser;
  }

  //* Public Methods
  Future<void> getClassesAsync() async {
    classes = await runBusyFuture(
      _usersRepo.getUserClasses(_authService.currUser.id),
      busyObject: classes,
    );
  }

  Future goToEditClassesPageAsync() async =>
      await _navigationService.navigateToClassesView();
}
