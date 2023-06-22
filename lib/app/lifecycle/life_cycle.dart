import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/show_logger.dart';

class JHAppLifeCycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        JHLogger.$.d(state.name);
        break;
      case AppLifecycleState.inactive:
        JHLogger.$.d(state.name);
        break;
      case AppLifecycleState.paused:
        JHLogger.$.d(state.name);
        break;
      case AppLifecycleState.detached:
        JHLogger.$.d(state.name);
        // App is detached from the view hierarchy
        break;
    }
  }
}
