import 'package:flutter/material.dart';
import 'package:parental_control/sign_in/email_sign_in_form_bloc_based.dart';
import 'package:parental_control/theme/theme.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Sign In'),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Card(
          /// Here we can change the child to
          ///
          /// EmailSignInFormChangeNotifier.create(context)
          /// EmailSignInFormBlocBased.create(context)
          /// EmailSignInFormStateful.create(context)
          /// According to your preferences
          child: EmailSignInFormBlocBased.create(context),
        ).p16,
      ),
    );
  }
}
