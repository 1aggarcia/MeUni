import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../app/app.locator.dart';
import '../models/user.dart' as meuni;
import '../repository/users_repo.dart';

/// Responsible for authenticating users
class AuthService {
  //* Private Properties
  final GoogleSignIn _googleSignIn = GoogleSignIn(hostedDomain: 'uw.edu');
  final UsersRepo _usersRepo = locator<UsersRepo>();

  String? _userId;
  meuni.User? _currUser;

  //* Public Properties
  /// Gets the currently signed in user. Throws an exception if [loginAsync] has
  /// not ran before.
  meuni.User get currUser => _currUser!;

  /// Checks is a user is logged in to the app.
  bool get isLoggedIn => _currUser != null;

  //* Public Methods

  /// Tries to login a user with Firebase. Returns [true] if possible and sets
  /// currUser if Firebase user has an account. Returns [false] if login failed.
  Future<bool> loginAsync() async {
    try {
      final googleUser = await _googleSignIn.signIn();

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

  /// Creates an account with the app, and update [currUser] appropriately.
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

  Future<void> logoutAsync() async {
    await _googleSignIn.signOut();

    _currUser = null;
    _userId = null;
  }
}
