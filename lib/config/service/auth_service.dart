import 'dart:async';
import 'dart:developer';

import 'package:flutter_bump_app/base/stream/base_stream_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthService {
  // static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  final googleAccount = BaseStreamController<GoogleSignInAccount?>(null);

  late final StreamSubscription<GoogleSignInAuthenticationEvent>
      _authenticationEvents;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    await _googleSignIn.initialize(
      clientId:
          '834324141628-189n7114rua1glpd87v5bbe1ulho5lmq.apps.googleusercontent.com',
    );
    _authenticationEvents =
        _googleSignIn.authenticationEvents.listen(_handleAuthenticationEvent);
  }

  @disposeMethod
  void dispose() {
    _authenticationEvents.cancel();
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      unawaited(_googleSignIn
          .initialize(
        clientId:
            '834324141628-189n7114rua1glpd87v5bbe1ulho5lmq.apps.googleusercontent.com',
      )
          .then((_) {
        /// This example always uses the stream-based approach to determining
        /// which UI state to show, rather than using the future returned here,
        /// if any, to conditionally skip directly to the signed-in state.
        _googleSignIn.attemptLightweightAuthentication();
      }));

      _googleSignIn.authenticate();

      // Create a new credential
      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.idToken,
      //   idToken: googleAuth.idToken,
      // );

      // // Sign in to Firebase with the Google credentials
      // final UserCredential userCredential = await _auth.signInWithCredential(credential);

      // // Save user info to Firestore (optional)
      // if (userCredential.user != null) {
      //   await _saveUserToFirestore(userCredential.user!);
      // }

      // return userCredential;
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  void _handleAuthenticationEvent(GoogleSignInAuthenticationEvent event) {
    if (event is GoogleSignInAuthenticationEventSignIn) {
      googleAccount.value = event.user;
      // log('User signed in: ${event.user.authentication.idToken}');
      // log('User signed in: ${event.user.displayName}');
    } else if (event is GoogleSignInAuthenticationEventSignOut) {
      log('User signed out');
      googleAccount.value = null;
    }
  }

  // void _handleAuthenticationError(Object error) {
  //   log('Authentication error: $error');
  // }

  // // Save user info to Firestore
  // static Future<void> _saveUserToFirestore(User user) async {
  //   log('Saving user to Firestore: ${user.uid}');
  // }

  // Sign out
  static Future<void> signOut() async {
    try {
      await Future.wait([
        // _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      print('Error signing out: $e');
      throw e;
    }
  }
}
