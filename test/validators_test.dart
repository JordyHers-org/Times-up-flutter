import 'package:flutter_test/flutter_test.dart';
import 'package:times_up_flutter/app/features/sign_in/validators.dart';

void main() {
  test('non empty string ', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid('test'), true);
  });

  test('empty string ', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid(''), false);
  });

  test('null string ', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid(null), false);
  });
}
