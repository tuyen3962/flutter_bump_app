import 'dart:async';
import 'dart:developer';

import 'package:flutter_bump_app/base/stream/base_stream_controller.dart';
import 'package:flutter_bump_app/config/constant/app_config.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/data/remote/exception/error_exception.dart';
import 'package:flutter_bump_app/data/remote/request/auth/google_mobile_login_request.dart';
import 'package:flutter_bump_app/data/repository/auth/iauth_repository.dart';
import 'package:flutter_bump_app/utils/device_info_util.dart';
import 'package:flutter_bump_app/utils/flash/toast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final IAuthRepository authRepository;
  final AccountService accountService;

  AuthService({required this.authRepository, required this.accountService});

  final googleAccount = BaseStreamController<GoogleSignInAccount?>(null);

  late final StreamSubscription<GoogleSignInAuthenticationEvent>
      _authenticationEvents;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    await _googleSignIn.initialize(clientId: AppConfig.clientId);
    _googleSignIn.attemptLightweightAuthentication();
    _authenticationEvents =
        _googleSignIn.authenticationEvents.listen(_handleAuthenticationEvent);
  }

  @disposeMethod
  void dispose() {
    _authenticationEvents.cancel();
  }

  // Sign in with Google
  Future<bool> signInWithGoogle() async {
    try {
      final result = await _googleSignIn.authenticate();
      final userInfo = await authRepository.googleMobileLogin(
          GoogleMobileLoginRequest(
              idToken: result.authentication.idToken ?? '',
              device: await DeviceInfoUtil.getDeviceInfo()));
      accountService.setAccount(userInfo);
      return true;
    } catch (e) {
      log('Error signing in with Google: $e');
      if (e is ErrorException && (e.error ?? '').isNotEmpty) {
        showSimpleToast(e.error ?? '');
      }
    }
    return false;
  }

  void _handleAuthenticationEvent(GoogleSignInAuthenticationEvent event) async {
    if (event is GoogleSignInAuthenticationEventSignIn) {
      googleAccount.value = event.user;
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
