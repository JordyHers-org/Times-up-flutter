import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:parental_control/models/notification_model.dart';

import '../helpers/test_helpers.mocks.dart';

void main() {
  late final MockNotificationService notificationService;

  setUp(() => notificationService = MockNotificationService());
  test('Notification Service', () {
    final notification = NotificationModel();
    when(notificationService.configureFirebaseMessaging())
        .thenReturn(notification);
    notificationService.configureFirebaseMessaging();

   verify(   notificationService.configureFirebaseMessaging()).called(1);
  });
}
