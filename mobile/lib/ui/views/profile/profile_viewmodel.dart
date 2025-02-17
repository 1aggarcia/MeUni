import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/user.dart';
import '../../../repository/users_repo.dart';
import '../../../services/auth_service.dart';

class ProfileViewModel extends FutureViewModel {
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

  //* Overridden Methods
  @override
  Future futureToRun() => getClassesAsync();

  //* Public Methods
  Future<void> getClassesAsync() async {
    classes = await _usersRepo.getUserClassesAsync(_authService.currUser.id);
  }

  Future goToEditClassesPageAsync() async =>
      await _navigationService.navigateToClassesView();
}
