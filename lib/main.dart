import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parental_control/app/config/screencontroller_config.dart';
import 'package:parental_control/services/app_usage_service.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/services/geo_locator_service.dart';
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
        Provider<GeoLocatorService>(create: (context) => GeoLocatorService()),
      ],
      child: TimesUpApp(),
    ),
  );
}

class TimesUpApp extends StatefulWidget {
  @override
  State<TimesUpApp> createState() => _TimesUpAppState();
}

class _TimesUpAppState extends State<TimesUpApp> {
  @override
  Widget build(BuildContext context) {
    final geoService = Provider.of<GeoLocatorService>(context, listen: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: FutureBuilder(
        future: geoService.getInitialLocation(),
        builder: (context, _) => ScreensController(),
      ),
    );
  }
}
