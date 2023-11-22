import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/user.dart';
import '../../../repository/users_repo.dart';
import '../../../services/auth_service.dart';

class ProfileViewModel extends BaseViewModel {
  //* Private Properties
  final _usersRepo = locator<UsersRepo>();

  final _authService = locator<AuthService>();

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
}
