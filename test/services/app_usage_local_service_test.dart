import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:times_up_flutter/services/app_usage_local_service.dart';

void main() {
  group('AppUsage Tests', () {
    const channel = MethodChannel('app_usage.methodChannel');

    setUp(TestWidgetsFlutterBinding.ensureInitialized);

    test(
      'getAppUsage returns a list of AppUsageInfo for Android',
      () async {
        //Arrange
        final startDate = DateTime(2023, 6, 10, 10);
        final endDate = DateTime(2023, 6, 10, 11);
        final fakeUsage = {
          'com.tiktok.app1': [3600.0, 1640880000.0, 1640883600.0],
          'com.messenger.app1': [1800.0, 1640887200.0, 1640890800.0],
        };

        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'getUsage') {
            return fakeUsage;
          }
          return null;
        });

        //Act
        final result =
            await AppUsage.getAppUsage(startDate, endDate, useMock: true);

        //Assert
        expect(result.length, equals(2));
        expect(result[0].packageName, equals('com.tiktok.app1'));
        expect(result[0].usage, equals(const Duration(hours: 1)));
        expect(
          result[0].startDate,
          DateTime.fromMillisecondsSinceEpoch(1640880000 * 1000),
        );
        expect(
          result[0].endDate,
          DateTime.fromMillisecondsSinceEpoch(1640883600 * 1000),
        );

        expect(result[1].packageName, equals('com.messenger.app1'));
        expect(result[1].usage, equals(const Duration(minutes: 30)));
        expect(
          result[1].startDate,
          DateTime.fromMillisecondsSinceEpoch(1640887200 * 1000),
        );
        expect(
          result[1].endDate,
          DateTime.fromMillisecondsSinceEpoch(1640890800 * 1000),
        );
      },
      skip: true,
    );

    test('getAppUsage throws an exception for non-Android platforms', () async {
      //Arrange
      final startDate = DateTime(2023, 6, 10, 10);
      final endDate = DateTime(2023, 6, 10, 11);

      //Act
      final result = AppUsage.getAppUsage(startDate, endDate, useMock: false);

      //Assert
      expect(result, throwsA(isA<AppUsageException>()));
    });
  });
}
