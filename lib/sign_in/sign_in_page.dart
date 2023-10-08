import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times_up_flutter/common_widgets/show_exeption_alert.dart';
import 'package:times_up_flutter/common_widgets/show_logger.dart';
import 'package:times_up_flutter/services/auth.dart';
import 'package:times_up_flutter/sign_in/email_sign_in_page.dart';
import 'package:times_up_flutter/sign_in/sign_in_button.dart';
import 'package:times_up_flutter/sign_in/sign_in_manager.dart';
import 'package:times_up_flutter/sign_in/social_sign_in_button.dart';
import 'package:times_up_flutter/utils/constants.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    required this.manager,
    required this.isLoading,
    Key? key,
  }) : super(key: key);
  final SignInManager manager;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (_, manager, __) => SignInPage(
              manager: manager,
              isLoading: isLoading.value,
            ),
          ),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseAuthException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(
      context,
      title: 'Sign in Failed',
      exception: exception,
    );
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await manager.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithEmail(BuildContext context) async {
    JHLogger.$.d('SIGNIN WITH EMAIL =>');
    try {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) => const EmailSignInPage(),
        ),
      );
    } on Exception catch (e) {
      JHLogger.$.e('ERROR THROWN $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return DecoratedBox(
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 180, child: _buildHeader()),
            const SizedBox(height: 28),
            SocialSignInButton(
              assetName: 'images/google-logo.png',
              text: 'Sign in With Google',
              textColor: Colors.black87,
              color: Colors.white,
              onPressed: () => isLoading ? null : _signInWithGoogle(context),
            ),
            const SizedBox(height: 8),
            SocialSignInButton(
              assetName: 'images/facebook-logo.png',
              text: 'Sign in With Facebook',
              textColor: Colors.white,
              color: const Color(0xFF334D92),
              onPressed: () => isLoading ? null : _signInWithFacebook(context),
            ),
            const SizedBox(height: 8),
            SignInButton(
              key: Keys.emailKeys,
              text: ' Sign in With email',
              textColor: Colors.white,
              color: Colors.teal[700],
              onPressed: () => isLoading ? null : _signInWithEmail(context),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Image.asset(
      'images/png/sign-up.png',
    );
  }
}
