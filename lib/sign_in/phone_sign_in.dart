import 'package:flutter/material.dart';
import 'package:parental_control/sign_in/phone_sign_bloc_based.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: PhoneSignInFormBlocBased(),
          ),
        ),
      ),
    );
  }
}
