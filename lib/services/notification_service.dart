// ignore_for_file: avoid_dynamic_calls

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:times_up_flutter/widgets/show_logger.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  // description
  importance: Importance.max,
);

class NotificationService {
  factory NotificationService() {
    return _singleton;
  }

  NotificationService._internal();
  static final NotificationService _singleton = NotificationService._internal();

  // Here the set up for cloud Messaging Android is being configured
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // The LocalPlugin method configures the android channel
  Future<void> localPlugin() async => await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  Future<void> initialize() async {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@drawable/parental_launch'),
      ),
    );
  }

// Create a new instance of Firebase Messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> _requestPermissions() async {
    final androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.requestPermission();
  }

  /// this function calls the Firebase Push notification
  @pragma('vm:entry-point')
  Future<void> configureFirebaseMessaging() async {
    try {
      JHLogger.$.d('A new onMessageOpenedApp event was published!');
      await _requestPermissions().whenComplete(() {
        FirebaseMessaging.onMessage.listen(_onBackgroundListening);
        FirebaseMessaging.onMessageOpenedApp.listen(_onBackgroundListening);
        FirebaseMessaging.onBackgroundMessage(_onBackgroundListening);
      });
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> _onBackgroundListening(RemoteMessage message) async {
    final notification = message.notification;
    final android = message.notification?.android;

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channel.id,
      channel.name,
      icon: android?.smallIcon,
      color: Colors.black,
      channelDescription: channel.description,
      importance: Importance.max,
      priority: Priority.high,
      colorized: true,
    );

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(android: androidPlatformChannelSpecifics),
      );
    }
  }
}
