import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../app/app.locator.dart';
import '../models/user.dart' as m;
import '../repository/users_repo.dart';

class AuthService {
  //* Private Properties
  final UsersRepo _usersRepo = locator<UsersRepo>();

  String? _userId;
  m.User? _currUser;

  //* Public Properties
  m.User get currUser => _currUser!;

  bool get isLoggedIn => _currUser != null;

  //* Public Methods
  Future<bool> loginAsync() async {
    try {
      final googleUser = await GoogleSignIn(hostedDomain: "uw.edu").signIn();

      if (googleUser == null) return false;

      // Obtain the auth details from the request
      final googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      _userId = userCredential.user!.uid;
      _currUser = await _usersRepo.getUserAsync(_userId!);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> signupAsync(
      String firstName, String lastName, int year, String pronouns) async {
    _currUser = await _usersRepo.addUserAsync(
      id: _userId!,
      firstName: firstName,
      lastName: lastName,
      year: year,
      pronouns: pronouns,
    );
  }

  Future<void> logoutAsync() async {}
}
