import 'package:flutter_test/flutter_test.dart';
import 'package:times_up_flutter/models/notification_model/notification_model.dart';

void main() {
  test('NotificationModel', () {
    // Test values
    const title = 'Notification Title';
    const body = 'Notification Body';
    const message = 'Notification Message';
    const id = 'notification_id';

    // Create the NotificationModel instance
    const notificationModel = NotificationModel(
      title: title,
      body: body,
      message: message,
      id: id,
    );

    // Verify the values
    expect(notificationModel.title, title);
    expect(notificationModel.body, body);
    expect(notificationModel.message, message);
    expect(notificationModel.id, id);
  });
}
