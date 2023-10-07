// ignore_for_file: avoid_setters_without_getters

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:times_up_flutter/common_widgets/show_logger.dart';

abstract class AuthBase {
  User? get currentUser;

  bool get isFirstLogin;

  void setFirstLogin({bool isFirstLogin});

  Future<User> signInAnonymously();

  Future<String> setToken();

  Future<void> signOut();

  Stream<User?> authStateChanges();

  Future<User> signInWithGoogle();

  Future<User> signInWithFacebook();

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<User> signUpUserWithEmailAndPassword(
    String email,
    String password,
    String name,
    String surname,
  );
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late String _token;
  bool _isFirstLogin = false;

  String get token => _token;

  @override
  void setFirstLogin({bool isFirstLogin = false}) {
    _isFirstLogin = isFirstLogin;
  }

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  bool get isFirstLogin => _isFirstLogin;

  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user!;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );
    JHLogger.$.v(email);
    return userCredential.user!;
  }

  @override
  Future<String> setToken() async {
    try {
      await _firebaseMessaging.getToken().then((token) {
        _token = token!;
        JHLogger.$.v(_token);
      });
    } catch (e) {
      JHLogger.$.e(e);
    }
    return _token;
  }

  @override
  Future<User> signUpUserWithEmailAndPassword(
    String email,
    String password,
    String name,
    String surname,
  ) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    _isFirstLogin = userCredential.additionalUserInfo!.isNewUser;

    JHLogger.$.v('Sign Up user complete  Name : $name');
    return userCredential.user!;
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        _isFirstLogin = userCredential.additionalUserInfo!.isNewUser;

        return userCredential.user!;
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google Id Token',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final fb = FacebookLogin();

    final response = await fb.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ],
    );
    switch (response.status) {
      case FacebookLoginStatus.success:
        final accessToken = response.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential(accessToken!.token),
        );
        _isFirstLogin = userCredential.additionalUserInfo!.isNewUser;

        JHLogger.$.v('Facebook Login Completed : ${accessToken.token}');
        return userCredential.user!;

      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in with facebook aborted by user',
        );
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
          message: response.error?.developerMessage,
        );
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    final facebookLogin = FacebookLogin();
    final authProvider = _firebaseAuth.currentUser!.providerData[0].providerId;

    switch (authProvider) {
      case 'google.com':
        await googleSignIn.signOut();
        break;
      case 'facebook.com':
        await facebookLogin.logOut();
        break;
      default:
        break;
    }
    _isFirstLogin = false;
    await _firebaseAuth.signOut();
  }
}
