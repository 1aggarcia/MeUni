import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../repository/users_repo.dart';

class ProfileViewModel extends BaseViewModel {
  final _usersRepo = locator<UsersRepo>();
  String get firstName => _usersRepo.loggedInUser!.firstName;
  String get lastName => _usersRepo.loggedInUser!.lastName;
  String get pronouns => _usersRepo.loggedInUser!.pronouns;
  int get year => _usersRepo.loggedInUser!.year;
  List<String> classes = [];

  bool isLoading = false;

  //* Public Methods
  Future getClassesAsync() async {
    isLoading = true;
    rebuildUi();

    classes = await _usersRepo.getUserClasses(_usersRepo.loggedInUser!.id);

    isLoading = false;
    rebuildUi();
  }





}
