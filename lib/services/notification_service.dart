// ignore_for_file: avoid_dynamic_calls

import 'dart:async';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:times_up_flutter/widgets/show_logger.dart';

const notificationChannelId = 'high_importance_channel';
const notificationChannelTitle = 'High Importance Notifications';
const notificationId = 800;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  notificationChannelId,
  notificationChannelTitle,
  description: 'This channel is used for important notifications.',
  importance: Importance.max,
);

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  Timer.periodic(const Duration(minutes: 15), (timer) async {
    // TODO(JORDY): IMPLEMENT DATA UPDATE HERE
    // final databaseStore = Provider.of<Database>(context!, listen: false);
    // final appUsage = Provider.of<AppUsageService>(context, listen: false);
    // JHLogger.$.e(' NOT READy ');
    // if (databaseStore.currentChild != null) {
    //   await databaseStore.liveUpdateChild(
    //     databaseStore.currentChild!,
    //     appUsage,
    //   );
    // }
    await NotificationService.flutterLocalNotificationsPlugin.show(
      notificationId,
      'Times Up - Monitoring',
      'Tracking App Usage and live location',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          notificationChannelId,
          notificationChannelTitle,
          icon: 'parental_launch',
          ongoing: true,
          importance: Importance.max,
        ),
      ),
    );
  });
}

class NotificationService {
  factory NotificationService() {
    return _singleton;
  }

  NotificationService._internal();
  static final NotificationService _singleton = NotificationService._internal();

  // Here the set up for cloud Messaging Android is being configured
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    try {
      final service = FlutterBackgroundService();
      await flutterLocalNotificationsPlugin
          .initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@drawable/parental_launch'),
        ),
      )
          .then((value) async {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);

        await service.configure(
          iosConfiguration: IosConfiguration(),
          androidConfiguration: AndroidConfiguration(
            onStart: onStart,
            isForegroundMode: true,
            initialNotificationTitle: 'Times Up Flutter Launched',
            initialNotificationContent: 'The app is tracking metadata',
            foregroundServiceNotificationId: notificationId,
          ),
        );
      });
    } catch (e) {
      JHLogger.$.e(e);
    }
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
