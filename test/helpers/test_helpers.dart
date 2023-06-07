import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/services/database.dart';
import 'package:parental_control/services/geo_locator_service.dart';
import 'package:parental_control/sign_in/email_sign_in_bloc.dart';

@GenerateMocks(
  [],
  customMocks: [
    //MockViewModels
    MockSpec<AuthBase>(
      onMissingStub: OnMissingStub.returnDefault,
    ),
    MockSpec<Database>(
      onMissingStub: OnMissingStub.returnDefault,
    ),
    MockSpec<GeoLocatorService>(
      onMissingStub: OnMissingStub.returnDefault,
    ),
    MockSpec<User>(
      onMissingStub: OnMissingStub.returnDefault,
    ),
    MockSpec<NavigatorObserver>(
      onMissingStub: OnMissingStub.returnDefault,
    ),
    MockSpec<EmailSignInBloc>(
      onMissingStub: OnMissingStub.returnDefault,
    ),

// @stacked-mock-spec
  ],
)
void registerServices() {
// @stacked-mock-register
}

class Helper {
  static Future<void> launch(Widget child, WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }
}
