import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:times_up_flutter/services/auth.dart';
import 'package:times_up_flutter/sign_in/sign_in_button.dart';
import 'package:times_up_flutter/sign_in/sign_in_page.dart';

import '../helpers/test_helpers.mocks.dart';

void main() {
  late MockAuthBase mockAuth;

  //First create Mock Navigation
  late MockNavigatorObserver mockNavigatorObvserver;
  setUp(() {
    ///A new mock authentication service will be created every time
    ///we run a test.
    mockAuth = MockAuthBase();
    mockNavigatorObvserver = MockNavigatorObserver();
  });

  /// Always create widgets with all the ancestors that are needed
  /// here we have to use MaterialApp
  Future<void> pumpSignInPage(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: const Builder(builder: SignInPage.create),

          //2. Pass is to the list of observers in MaterialApp
          navigatorObservers: [mockNavigatorObvserver],
        ),
      ),
    );

    //3.Verify if it is pushed right here
    verify(mockNavigatorObvserver.didPush(any, any)).called(1);
  }

  testWidgets('email&password navigation', (WidgetTester tester) async {
    await pumpSignInPage(tester);

    final emailSignInButton = find.byType(SignInButton);
    expect(emailSignInButton, findsNWidgets(1));
    //4. Write the test to trigger the tap
    await tester.tap(emailSignInButton);
    await tester.pumpAndSettle();

    //5. Verify again if the mockNavigatorObvserver.
    // didPush(any, any)).called(1);
    verify(mockNavigatorObvserver.didPush(any, any)).called(1);
  });
}
