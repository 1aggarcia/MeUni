import 'package:meuni_mobile/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../repository/users_repo.dart';

class ProfileViewModel extends BaseViewModel {
  final _usersRepo = locator<UsersRepo>();
  final _authService = locator<AuthService>();
  String get firstName => _authService.currUser.firstName;
  String get lastName => _authService.currUser.lastName;
  String get pronouns => _authService.currUser.pronouns;
  int get year => _authService.currUser.year;
  List<String> classes = [];

  bool isLoading = false;

  //* Public Methods
  Future getClassesAsync() async {
    isLoading = true;
    rebuildUi();

    classes = await _usersRepo.getUserClasses(_authService.currUser.id);

    isLoading = false;
    rebuildUi();
  }
}
