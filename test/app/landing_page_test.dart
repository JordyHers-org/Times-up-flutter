import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:parental_control/app/landing_page.dart';
import 'package:parental_control/app/pages/child_page.dart';
import 'package:parental_control/app/pages/parent_page.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/services/geo_locator_service.dart';
import 'package:parental_control/sign_in/sign_in_page.dart';
import 'package:provider/provider.dart';

import '../helpers/test_helpers.mocks.dart';

void main() {
  late MockAuthBase mockAuth;
  late MockGeoLocatorService mockGeoLocatorService;
  late MockDatabase mockDatabase;
  late StreamController<User> onAuthStateChangedController;

  setUp(() {
    ///A new mock authentication service will be created every time
    ///we run a test.
    mockAuth = MockAuthBase();
    mockDatabase = MockDatabase();
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

  /// Always create widgets with all the ancestors that are needed
  /// here we have to use MaterialApp
  Future<void> pumpLandingPage(WidgetTester tester,
      {VoidCallback? onSignedIn}) async {
    await tester.pumpWidget(Provider<AuthBase>(
      create: (_) => mockAuth,
      child: Provider<GeoLocatorService>(
        create: (_) => mockGeoLocatorService,
        child: MaterialApp(
          home: Scaffold(
            body: LandingPage(),
          ),
        ),
      ),
    ));

    await tester.pump();
  }

  testWidgets('stream waiting', (WidgetTester tester) async {
    stubOnAuthStateChangesYields([]);
    await pumpLandingPage(tester);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('null User', (WidgetTester tester) async {
    stubOnAuthStateChangesYields([]);
    await pumpLandingPage(tester);
    expect(find.byType(SignInPage), findsNWidgets(0));
  });
  testWidgets(
    'non-null User',
    (WidgetTester tester) async {
      stubOnAuthStateChangesYields([]);
      await pumpLandingPage(tester);
      expect(find.byType(ParentPage), findsNothing);
      expect(find.byType(ChildPage), findsNothing);
    },
  );
}
