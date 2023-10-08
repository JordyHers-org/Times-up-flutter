// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times_up_flutter/app/app.dart';
import 'package:times_up_flutter/bootstrap.dart';
import 'package:times_up_flutter/firebase_options.dart';
import 'package:times_up_flutter/services/app_usage_service.dart';
import 'package:times_up_flutter/services/auth.dart';
import 'package:times_up_flutter/services/geo_locator_service.dart';
import 'package:times_up_flutter/services/internet_connectivity_service.dart';
import 'package:times_up_flutter/services/notification_service.dart';
import 'package:times_up_flutter/theme/theme_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).whenComplete(() async {
    await _notificationServiceListener();
  });

  await bootstrap(
    () => MultiProvider(
      providers: [
        Provider<AuthBase>(create: (context) => Auth()),
        Provider<AppUsageService>(create: (context) => AppUsageService()),
        Provider<GeoLocatorService>(
          create: (context) => GeoLocatorService()..getInitialLocation(),
        ),
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        ),
        ChangeNotifierProvider<InternetConnectivityService>(
          create: (context) => InternetConnectivityService()
            ..checkConnectionStatus()
            ..getInitialConnectionStatus(),
        ),
        ChangeNotifierProvider<ThemeNotifier>(
            create: (context) => ThemeNotifier()..toggleTheme()),
      ],
      child: const TimesUpApp(),
    ),
  );
}

Future<void> _notificationServiceListener() async {
  final notificationService = NotificationService();
  await notificationService.initialize().whenComplete(
        () async => notificationService.configureFirebaseMessaging(),
      );
}
