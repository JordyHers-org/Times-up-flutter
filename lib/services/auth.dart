import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;

  Future<User> signInAnonymously();

  Future<String> setToken();
  //signOut method
  Future<void> signOut();

  Stream<User> authStateChanges();

  Future<User> signInWithGoogle();

  Future<User> signInWithFacebook();

  Future<User> signUpUserWithEmailAndPassword(
      String email, String password, String name, String surname);

  Future<User> signInWithEmailAndPassword(String email, String password);
}


class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String _token;

  String get token => _token;

  ///Streams allow us to control all changes applied
  ///The stream is declare as follow final controller = StreamController();
  ///controller.sink.add() adds value to the stream
  ///controller.stream.listen gets the values.
  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  /// This code is used to get the current user after The User has Logged in
  @override
  User get currentUser => _firebaseAuth.currentUser;

  ///Sign In Anonymously Method
  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  ///Sign in with Email and Password
  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );
    print('Welcome back dear user _____=>  $email ');
    return userCredential.user;
  }

  @override

  /// This Method takes the device token Id which will be used later
  Future<String> setToken() async {
    try {
      await _firebaseMessaging.getToken().then((token) {
        _token = token;
        print('Device Token: $_token');
      });
    } catch (e) {
      print(e);
    }
    return _token;
  }

  ///Register with email and passwords
  @override
  Future<User> signUpUserWithEmailAndPassword(String email, String password,
      String name, String surname) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    print('Sign Up user complete  Name : $name');
    return userCredential.user;
  }

  ///Sign In with Google Method
  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return userCredential.user;
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


  /// Sign in With Facebook credentials method
  /// Facebook login will ask for permission
  /// then initiate cases of responses
  @override
  Future <User> signInWithFacebook() async {
    final fb = FacebookLogin();

    final response = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,

    ]);
    switch (response.status) {
      case FacebookLoginStatus.success:
        final accessToken = response.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential(accessToken.token),
        );
        print('Facebook Login Completed : ${accessToken.token}');
        return userCredential.user;

      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in with facebook aborted by user',
        );
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
          message: response.error.developerMessage,
        );
      default:
        throw UnimplementedError();
    }
  }


  ///Sign Out Method from Firebase and Google
  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
