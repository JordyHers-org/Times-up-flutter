import 'package:flutter/foundation.dart';

class NotificationModel with ChangeNotifier {
  String? title;
  String? body;
  String? message;
  String? id;

  NotificationModel({title, body, message, id}) {
    this.id = id;
    this.title = title;
    this.body = body;
    this.message = message;
  }

  factory NotificationModel.fromMap(Map<dynamic, dynamic> data, documentId) {
    //final String id = data['id'];
    final String title = data['title'];
    final String message = data['message'];

    return NotificationModel(
      title: title,
      body: 'body',
      message: message,
      id: documentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'message': message,
    };
  }

  @override
  String toString() {
    return 'id : $id  title: $title  message: $message body: $body';
  }
}
