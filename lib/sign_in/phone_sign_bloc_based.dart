import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parental_control/app/pages/parent_page.dart';
import 'package:parental_control/common_widgets/form_submit_button.dart';
import 'package:parental_control/common_widgets/show_logger.dart';
class PhoneSignInFormBlocBased extends StatefulWidget {
  PhoneSignInFormBlocBased({Key? key}) : super(key: key);

  @override
  _PhoneSignInFormBlocBasedState createState() =>
      _PhoneSignInFormBlocBasedState();
}

class _PhoneSignInFormBlocBasedState extends State<PhoneSignInFormBlocBased> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  late String verificationId;
  late String _id;
  late String phoneNo;
  late String _verificationCode;

  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _otpFocusNode = FocusNode();
  bool _isVisible = false;

  ///void Dispose Method
  @override
  void dispose() {
    _phoneNumberController.dispose();
    _phoneNumberFocusNode.dispose();

    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  /// THIS FUNCTION gets the Phone authentication the sms Code provided
  Future<void> signInWithOTP(smsCode, verId) async {
    var authCred =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    await signIn(authCred).whenComplete(
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ParentPage()),
      ),
    );
  }

  /// THIS FUNCTION SIGN THE USER using the sms Code provided
  Future<void> signIn(AuthCredential authCred) async {
    await FirebaseAuth.instance.signInWithCredential(authCred);
  }

  /// THIS FUNCTION Verify the phone number entered
  Future<void> verifyPhone(phoneNo) async {
    Logging.logger.d('Phone number reached verifyphone $phoneNo');
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      signIn(authResult);
    };

    final verificationfailed = (FirebaseAuthException authException) {
      Logging.logger.e('${authException.message}');

    };

    final smsSent = (String verId, [int? forceResend]) {
      verificationId = verId;
    };

    final autoTimeout = (String verId) {
      verificationId = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }

  ///--------------------------------------------------------------------------

  List<Widget> _buildChildren(BuildContext context) {
    return [
      _buildPhoneNumberTextField(),
      SizedBox(height: 8.0),
      _buildOTP(),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: _isVisible == true ? 'Login' : 'Send sms Code',
        onPressed: () async {
          if (_isVisible == false) {
            _turnOnOtpField();
          }
          _isVisible == true
              ? await verifyPhone(phoneNo)
              : await signInWithOTP(_verificationCode, _id);
        },
      ),
      SizedBox(height: 8.0),
    ];
  }

  Widget _buildPhoneNumberTextField() {
    return TextField(
      controller: _phoneNumberController,
      decoration: InputDecoration(
        labelText: 'Phone',
        hintText: '5XX XXX XX XX',
      ),
      autocorrect: false,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {},
      onChanged: (value) {
        setState(() {
          phoneNo = '+90${_phoneNumberController.text}';
          Logging.logger.e('This is the phone number taken : $phoneNo');
        });
      },
    );
  }

  Widget _buildOTP() {
    return _isVisible == true
        ? TextField(
            controller: _otpController,
            decoration: InputDecoration(
              labelText: 'OTP',
              hintText: ' 1 1 1 1 1',
            ),
            autocorrect: false,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            onEditingComplete: () {},
            onChanged: (val) {
              setState(() {
                _verificationCode = val;
              });
            },
          )
        : Opacity(opacity: 0);
  }

  void _turnOnOtpField() {
    setState(() {
      _isVisible = true;
    });
  }

  ///------------------------------ Widgets --------------

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: _buildChildren(context),
        ),
      ),
    );
  }
}
