import 'package:parental_control/sign_in/validators.dart';

/// This enum takes care of the different states of the sign in form
enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators {
  EmailSignInModel(
      {this.name = '',
      this.surname = '',
      this.email = '',
      this.password = '',
      this.formType = EmailSignInFormType.signIn,
      this.isLoading = false,
      this.submitted = false});

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Sign in '
        : ' Create an account ';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? ' Need an account ? Register'
        : 'Have an account? Sign in';
  }

  bool get canSubmitSignIn {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  bool get canSubmitRegister {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        nameValidator.isValid(name) &&
        surnameValidator.isValid(surname) &&
        !isLoading;
  }

  bool get showErrorTextName {
    return submitted && !nameValidator.isValid(name);
  }

  bool get showErrorTextSurname {
    return submitted && !surnameValidator.isValid(surname) && !isLoading;
  }

  bool get showErrorTextEmail {
    return submitted && !emailValidator.isValid(email);
  }

  bool get showErrorTexPassword {
    return submitted && !passwordValidator.isValid(password);
    ;
  }

  final String name;
  final String surname;
  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;

  EmailSignInModel copyWith({
    String? name,
    String? surname,
    String? email,
    String? password,
    EmailSignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
// model.copyWith(email:email)
}
