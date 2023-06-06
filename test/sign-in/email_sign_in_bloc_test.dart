import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:parental_control/sign_in/email_sign_in_bloc.dart';
import 'package:parental_control/sign_in/email_sign_in_model.dart';

import '../helpers/test_helpers.mocks.dart';

void main() {
  late MockAuthBase mockAuth;
  late EmailSignInBloc bloc;

  setUp(() {
    mockAuth = MockAuthBase();
    bloc = EmailSignInBloc(auth: mockAuth);
  });

  tearDown(() {
    bloc.dispose();
  });

  test(
    'When email is updated'
    'AND password is updated'
    'AND submit is called'
    'THEN modelstream emits the correct event',
    () async {
      when(mockAuth.signInWithEmailAndPassword(any.toString(), any.toString()))
          .thenThrow(PlatformException(code: 'ERROR'));

      expect(
        bloc.modelStream,
        emitsInOrder([
          EmailSignInModel(),
          EmailSignInModel(email: 'email@email.com'),
          EmailSignInModel(
            email: 'email@email.com',
            password: 'password',
          ),
          EmailSignInModel(
            email: 'email@email.com',
            password: 'password',
            submitted: true,
            isLoading: true,
          ),
          EmailSignInModel(
            email: 'email@email.com',
            password: 'password',
            submitted: true,
            isLoading: false,
          ),
        ]),
      );
      bloc.updateEmail('email@email.com');

      bloc.updatePassword('password');

      try {
        await bloc.submit();
      } catch (_) {}
    },
    skip: true,
  );
}
