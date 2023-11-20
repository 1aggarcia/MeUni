import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meuni_mobile/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../repository/users_repo.dart';
import '../../../models/user.dart' as m;

class LoginViewModel extends BaseViewModel {
  //* Private Properties
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _usersRepo = locator<UsersRepo>();

  //* Public Methods
  Future signInWithGoogleAsync() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(hostedDomain: "uw.edu").signIn();

    if (googleUser == null) {
      _dialogService.showDialog(
        title: 'Error!',
        description: 'Please try again another time.',
      );
    } else {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      String userId = userCredential.user!.uid;

      m.User? user = await _usersRepo.getUserAsync(userId);

      if (user != null) {
        // Set logged in user
        _usersRepo.loggedInUser = user;

        _navigationService.replaceWithHomeView();
      } else {
        // Create Profile
        _navigationService.replaceWithCreateProfileView(userId: userId);
      }
    }
  }
}
