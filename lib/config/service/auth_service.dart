import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // Get current user
  static User? get currentUser => _auth.currentUser;

  // Stream of auth state changes
  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with Google
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      unawaited(_googleSignIn
          .initialize(
        clientId: '834324141628-189n7114rua1glpd87v5bbe1ulho5lmq.apps.googleusercontent.com',
      )
          .then((_) {
        _googleSignIn.authenticationEvents.listen(_handleAuthenticationEvent).onError(_handleAuthenticationError);

        /// This example always uses the stream-based approach to determining
        /// which UI state to show, rather than using the future returned here,
        /// if any, to conditionally skip directly to the signed-in state.
        _googleSignIn.attemptLightweightAuthentication();
      }));

      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Save user info to Firestore (optional)
      if (userCredential.user != null) {
        await _saveUserToFirestore(userCredential.user!);
      }

      return userCredential;
    } catch (e) {
      print('Error signing in with Google: $e');
    }
    return null;
  }

  static void _handleAuthenticationEvent(GoogleSignInAuthenticationEvent event) {
    if (event is GoogleSignInAuthenticationEventSignIn) {
      log('User signed in: ${event.user.displayName}');
    } else if (event is GoogleSignInAuthenticationEventSignOut) {
      log('User signed out');
    }
  }

  static void _handleAuthenticationError(Object error) {
    log('Authentication error: $error');
  }

  // Save user info to Firestore
  static Future<void> _saveUserToFirestore(User user) async {
    log('Saving user to Firestore: ${user.uid}');
  }

  // Sign out
  static Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      print('Error signing out: $e');
      throw e;
    }
  }
}
