import 'package:flutter/material.dart';
import 'package:times_up_flutter/sign_in/email_sign_in_form_bloc_based.dart';
import 'package:times_up_flutter/theme/theme.dart';

class EmailSignInPage extends StatelessWidget {
  const EmailSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Sign In'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: CustomColors.indigoDark,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: EmailSignInFormBlocBased.create(context),
          ),
        ),
      ),
    );
  }
}
