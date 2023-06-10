import 'package:flutter_test/flutter_test.dart';
import 'package:parental_control/models/notification_model/notification_model.dart';

void main() {
  test('NotificationModel', () {
    // Test values
    const String? title = 'Notification Title';
    const String? body = 'Notification Body';
    const String? message = 'Notification Message';
    const String? id = 'notification_id';

    // Create the NotificationModel instance
    final notificationModel = NotificationModel(
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
