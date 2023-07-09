// ignore_for_file: one_member_abstracts

abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String? value) {
    if (value != null) {
      return value.isNotEmpty;
    }
    return false;
  }
}

mixin EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final StringValidator nameValidator = NonEmptyStringValidator();
  final StringValidator surnameValidator = NonEmptyStringValidator();

  final String inValidEmailErrorText = "Email can't be empty";
  final String inValidPasswordErrorText = "Password can't be empty";
  final String inValidNameErrorText = "Name can't be empty";
  final String inValidSurnameErrorText = "Surname can't be empty";
  final String signInFailedText = 'Sign in Failed';
}
