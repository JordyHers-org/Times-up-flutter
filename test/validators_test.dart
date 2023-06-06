import 'package:flutter_test/flutter_test.dart';
import 'package:parental_control/sign_in/validators.dart';

void main() {
  test('non empty string ', () {
    final validator = NonEmptyStringValidator();

    ///here we pass a string [test] to check if the method isValid will return true
    ///
    expect(validator.isValid('test'), true);
  });

  test('empty string ', () {
    final validator = NonEmptyStringValidator();

    ///here we pass a string [test] to check if the method isValid will return false
    /// when the string is empty
    expect(validator.isValid(''), false);
  });

  test('null string ', () {
    final validator = NonEmptyStringValidator();

    ///here we pass a string [test] to check if the method isValid will return null
    /// when the string is empty
    expect(validator.isValid(null), false);
  });
}
