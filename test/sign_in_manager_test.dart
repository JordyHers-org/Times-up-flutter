import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:parental_control/sign_in/sign_in_manager.dart';

import 'mocks.dart';

class MockValueNotifier<T> extends ValueNotifier<T> {
  MockValueNotifier(T value) : super(value);

  List<T> values = [];

  @override
  set value(T newValue) {
    values.add(newValue);
    super.value = newValue;
  }
}

void main() {
  late MockAuth mockAuth;
  late MockValueNotifier<bool> isLoading;
  late SignInManager manager;
  setUp(() {
    mockAuth = MockAuth();
    isLoading = MockValueNotifier<bool>(false);
    manager = SignInManager(auth: mockAuth, isLoading: isLoading);
  });

  test('sign-in success', () async {
    when(mockAuth.signInAnonymously())
        .thenAnswer((_) => Future.value(MockUser.uid('1234567')));
    await manager.signInAnonymously();

    expect(isLoading.values, [true]);
  });

  test('sign-in failure', () async {
    when(mockAuth.signInAnonymously())
        .thenThrow(PlatformException(code: 'ERROR', message: 'sign in failed'));
    try {
      await manager.signInAnonymously();
    } catch (e) {
      expect(isLoading.values, [true, false]);
    }
  });
}
