// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';
// import 'package:parental_control/sign_in/sign_in_page.dart';
// import 'package:parental_control/services/auth.dart';
// import 'mocks.dart';
//
//
// void main() {
//   MockAuth mockAuth;
//
//   //First create Mock Navigation
//   MockNavigatorObvserver mockNavigatorObvserver;
//   setUp(() {
//     ///A new mock authentication service will be created every time
//     ///we run a test.
//     mockAuth = MockAuth();
//     mockNavigatorObvserver = MockNavigatorObvserver();
//   });
//
//   /// Always create widgets with all the ancestors that are needed
//   /// here we have to use MaterialApp
//   Future<void> pumpSignInPage(WidgetTester tester) async {
//     await tester.pumpWidget(Provider<AuthBase>(
//       create: (_) => mockAuth,
//       child: MaterialApp(
//           home: Builder(builder:(context)=> SignInPage.create(context)),
//
//               //2. Pass is to the list of observers in MaterialApp
//               navigatorObservers: [mockNavigatorObvserver],
//       ),
//     ));
//
//     //3.Verify if it is pushed right here
//     verify(mockNavigatorObvserver.didPush(any, any)).called(1);
//
//   }
//
//   testWidgets('email&password navigation', (WidgetTester tester) async{
//     await pumpSignInPage(tester);
//
//     final emailSignInButton = find.byKey(SignInPage.emailpasswordKey);
//     expect(emailSignInButton, findsOneWidget);
//     //4. Write the test to trigger the tap
//     await tester.tap(emailSignInButton);
//     await tester.pumpAndSettle();
//
//     //5. Verify again if the mockNavigatorObvserver.didPush(any, any)).called(1);
//      verify(mockNavigatorObvserver.didPush(any, any)).called(1);
//   });
// }
