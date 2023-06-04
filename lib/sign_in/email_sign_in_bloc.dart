import 'dart:async';

import 'package:parental_control/services/auth.dart';

import 'email_sign_in_model.dart';

class EmailSignInBloc {
  EmailSignInBloc({required this.auth});

  final AuthBase auth;

  final StreamController<EmailSignInModel> _modelController =
      StreamController();

  Stream<EmailSignInModel> get modelStream => _modelController.stream;

  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  /// Submit function is called when the button is pressed
  Future<void> submit() async {
    print('Submitted called');
    updateWith(submitted: true, isLoading: true);
    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.signUpUserWithEmailAndPassword(
          _model.email,
          _model.password,
          _model.name,
          _model.surname,
        );
      }
      // Navigator.of(context).pop();
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void toggleFormType() {
    final formType = _model.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;

    ///This function clears the field everytime the user toggles between
    ///
    /// [Register] and [SignIn]
    updateWith(
      email: '',
      password: '',
      name: '',
      surname: '',
      submitted: false,
      formType: formType,
      isLoading: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void updateName(String name) => updateWith(name: name);

  void updateSurname(String surname) => updateWith(surname: surname);

  void updateWith({
    String? email,
    String? password,
    String? name,
    String? surname,
    EmailSignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    // update model
    _model = _model.copyWith(
      name: name ?? _model.name,
      surname: surname ?? _model.surname,
      email: email ?? _model.email,
      password: password ?? _model.password,
      formType: formType ?? _model.formType,
      isLoading: isLoading ?? _model.isLoading,
      submitted: submitted ?? _model.submitted,
    );

    //add updated model to _modelController
    _modelController.add(_model);
  }
}
