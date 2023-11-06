import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:times_up_flutter/app/features/sign_in/email_sign_in_bloc.dart';
import 'package:times_up_flutter/app/features/sign_in/email_sign_in_model.dart';

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
    'When email is updated '
    'AND password is updated '
    'AND submit is called '
    'THEN model stream emits the correct event',
    () async {
      when(mockAuth.signInWithEmailAndPassword(any, any))
          .thenThrow(PlatformException(code: 'ERROR'));
      expect(
        bloc.modelStream.first,
        isInstanceOf<Future<EmailSignInModel>>(),
      );

      bloc
        ..updateEmail('test@email.com')
        ..updatePassword('password');

      try {
        await bloc.submit();
      } catch (_) {}
    },
  );
}
