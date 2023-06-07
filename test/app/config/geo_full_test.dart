import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parental_control/app/config/geo_full.dart';
import 'package:parental_control/constants.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_helpers.mocks.dart';
import '../../mocks.dart';

void main() {
  late MockDatabase mockDatabase;
  late MockAuthBase mockAuthBase;
  late Position position;

  setUp(() {
    ///A new mock authentication service will be created every time
    ///we run a test.
    mockDatabase = MockDatabase();
    mockAuthBase = MockAuthBase();
    position = Dummy.position;
  });

  testWidgets(
    'GeoFull Test',
    (tester) async {
      final child = GeoFull(position, mockDatabase);
      await Helper.launch(child, tester);

      // Use the Finder to locate the widget to be zoomed
      final map = find.byType(GoogleMap);

      expect(map, findsOneWidget);
    },
    skip: true,
  );
  testWidgets(
    'GeoFull Test',
    (tester) async {
      final child = GeoFull(position, mockDatabase);
      await Helper.launch(child, tester);

      // Use the Finder to locate the GoogleMap widget
      final googleMapFinder = find.descendant(
        of: find.byType(Container),
        matching: find.byKey(Keys.googleMapKeys),
      );

      // Simulate a pinch gesture on the widget
      final gesture =
          await tester.startGesture(tester.getCenter(googleMapFinder));
      await gesture.panZoomStart(
        const Offset(1.0, 1.0),
      );
      await tester.pump();

      // Simulate a pinch-out gesture on the widget
      await gesture.panZoomStart(
        const Offset(0.5, 0.5),
      );
      await tester.pump();

      // Expect the zoom level to change
      expect(find.text('Zoom Level: 1.0'), findsNothing);

      // Dispose the gesture
      await gesture.up();
    },
    skip: true,
  );
}
