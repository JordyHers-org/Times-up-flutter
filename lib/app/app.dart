import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:times_up_flutter/app/config/screencontroller_config.dart';
import 'package:times_up_flutter/theme/theme.dart';
import 'package:times_up_flutter/utils/app_strings.dart';

class TimesUpApp extends StatefulWidget {
  const TimesUpApp({Key? key}) : super(key: key);

  @override
  State<TimesUpApp> createState() => _TimesUpAppState();
}

class _TimesUpAppState extends State<TimesUpApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const ScreensController(),
    );
  }
}
