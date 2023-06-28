import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:times_up_flutter/app/pages/child_page.dart';
import 'package:times_up_flutter/app/pages/parent_page.dart';
import 'package:times_up_flutter/sign_in/sign_in_page.dart';

import '../helpers/test_helpers.dart';
import '../helpers/test_helpers.mocks.dart';

void main() {
  late MockAuthBase mockAuth;
  late MockGeoLocatorService mockGeoLocatorService;
  late StreamController<User> onAuthStateChangedController;

  setUp(() {
    ///A new mock authentication service will be created every time
    ///we run a test.
    mockAuth = MockAuthBase();
    mockGeoLocatorService = MockGeoLocatorService();
    onAuthStateChangedController = StreamController<User>();
  });

  tearDown(() {
    onAuthStateChangedController.close();
  });

  void stubOnAuthStateChangesYields(Iterable<User> onAuthStateChanges) {
    onAuthStateChangedController.addStream(
      Stream<User>.fromIterable(onAuthStateChanges),
    );
    when(mockAuth.authStateChanges()).thenAnswer((_) {
      return onAuthStateChangedController.stream;
    });
  }

  testWidgets('stream waiting', (WidgetTester tester) async {
    stubOnAuthStateChangesYields([]);
    await Helper.pumpLandingPage(
      tester,
      mockAuthBase: mockAuth,
      mockGeoLocatorService: mockGeoLocatorService,
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('null User', (WidgetTester tester) async {
    stubOnAuthStateChangesYields([]);
    await Helper.pumpLandingPage(
      tester,
      mockAuthBase: mockAuth,
      mockGeoLocatorService: mockGeoLocatorService,
    );
    expect(find.byType(SignInPage), findsNWidgets(0));
  });
  testWidgets(
    'non-null User',
    (WidgetTester tester) async {
      stubOnAuthStateChangesYields([]);
      await Helper.pumpLandingPage(
        tester,
        mockAuthBase: mockAuth,
        mockGeoLocatorService: mockGeoLocatorService,
      );
      expect(find.byType(ParentPage), findsNothing);
      expect(find.byType(ChildPage), findsNothing);
    },
  );
}
