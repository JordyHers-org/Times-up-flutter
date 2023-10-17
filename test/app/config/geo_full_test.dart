import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:times_up_flutter/app/config/geo_full.dart';
import 'package:times_up_flutter/services/auth.dart';
import 'package:times_up_flutter/services/geo_locator_service.dart';
import 'package:times_up_flutter/utils/constants.dart';

import '../../helpers/test_helpers.mocks.dart';
import '../../mocks.dart';

void main() {
  late MockDatabase mockDatabase;
  late MockAuthBase mockAuthBase;
  late MockGeoLocatorService mockGeoLocatorService;
  late Position position;

  setUp(() {
    ///A new mock authentication service will be created every time
    ///we run a test.
    mockAuthBase = MockAuthBase();
    mockGeoLocatorService = MockGeoLocatorService();
    mockDatabase = MockDatabase();
    position = Dummy.position;
  });

  testWidgets(
    'GeoFull Test',
    (tester) async {
      final child = Provider<GeoLocatorService>(
        create: (_) => mockGeoLocatorService,
        child: Provider<AuthBase>(
          create: (_) => mockAuthBase,
          builder: (context, __) => MaterialApp(
            home: GeoFull.create(
              context,
              position: position,
              database: mockDatabase,
              auth: mockAuthBase,
              locations: [],
            ),
          ),
        ),
      );
      await tester.pumpWidget(child);

      // Use the Finder to locate the widget to be zoomed
      final map = find.byType(GoogleMap);

      expect(map, findsOneWidget);
    },
  );
  testWidgets(
    'GeoFull Test',
    (tester) async {
      final child = Provider<GeoLocatorService>(
        create: (_) => mockGeoLocatorService,
        child: Provider<AuthBase>(
          create: (_) => mockAuthBase,
          builder: (context, __) => MaterialApp(
            home: GeoFull.create(
              context,
              position: position,
              database: mockDatabase,
              auth: mockAuthBase,
              locations: [],
            ),
          ),
        ),
      );
      await tester.pumpWidget(child);

      // Use the Finder to locate the GoogleMap widget
      final googleMapFinder = find.descendant(
        of: find.byType(Container),
        matching: find.byKey(Keys.googleMapKeys),
      );

      // Simulate a pinch gesture on the widget
      final gesture =
          await tester.startGesture(tester.getCenter(googleMapFinder));
      await gesture.panZoomStart(
        const Offset(1, 1),
      );
      await tester.pump();

      // Simulate a pinch-out gesture on the widget
      await gesture.panZoomStart(
        const Offset(0.5, 0.5),
      );
      await tester.pump();

      // Dispose the gesture
      await gesture.up();
    },
    skip: true,
  );
}
