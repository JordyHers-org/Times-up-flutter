import 'package:flutter/material.dart';
import 'package:parental_control/sign_in/phone_sign_bloc_based.dart';
import 'package:parental_control/theme/theme.dart';

class PhoneSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Enter Phone Number'),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Card(
          child: PhoneSignInFormBlocBased(),
        ).p16,
      ),
    );
  }
}
