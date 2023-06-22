import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parental_control/app/config/screencontroller_config.dart';
import 'package:parental_control/app/lifecycle/life_cycle.dart';
import 'package:parental_control/services/app_usage_service.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/services/geo_locator_service.dart';
import 'package:parental_control/services/notification_service.dart';
import 'package:parental_control/theme/theme.dart';
import 'package:parental_control/utils/app_strings.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthBase>(create: (context) => Auth()),
        Provider<AppUsageService>(create: (context) => AppUsageService()),
        Provider<GeoLocatorService>(
          create: (context) => GeoLocatorService()..getInitialLocation(),
        ),
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        ),
      ],
      child: TimesUpApp(),
    ),
  );
}

class TimesUpApp extends StatefulWidget {
  @override
  State<TimesUpApp> createState() => _TimesUpAppState();
}

class _TimesUpAppState extends State<TimesUpApp> with WidgetsBindingObserver {
  late JHAppLifeCycleObserver appLifeCycleObserver;

  @override
  void initState() {
    super.initState();
    appLifeCycleObserver = JHAppLifeCycleObserver();
    WidgetsBinding.instance.addObserver(appLifeCycleObserver);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(appLifeCycleObserver);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: ScreensController(),
    );
  }
}
