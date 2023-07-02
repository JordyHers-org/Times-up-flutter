import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:times_up_flutter/models/notification_model/notification_model.dart';

import '../helpers/test_helpers.mocks.dart';

void main() {
  late final MockNotificationService notificationService;

  setUp(() => notificationService = MockNotificationService());
  test('Notification Service', () {
    const notification = NotificationModel(
      title: '',
      body: '',
      message: '',
      id: '',
    );
    when(notificationService.configureFirebaseMessaging())
        .thenAnswer((_) => notification);
    notificationService.configureFirebaseMessaging();

    verify(notificationService.configureFirebaseMessaging()).called(1);
  });
}
