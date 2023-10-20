import 'package:background_fetch/background_fetch.dart';
import 'package:times_up_flutter/widgets/show_logger.dart';

@pragma('vm:entry-point')
Future<void> backgroundFetchHeadlessTask(HeadlessTask task) async {
  final taskId = task.taskId;
  final isTimeout = task.timeout;

  JHLogger.$.e('[BackgroundFetch] Headless event received.');

  if (isTimeout) {
    JHLogger.$.e('[BackgroundFetch] Headless task timed-out: $taskId');
    BackgroundFetch.finish(taskId);
    return;
  }
}

Future<void> configureBackgroundFetch() async {
  await BackgroundFetch.configure(
    BackgroundFetchConfig(
      minimumFetchInterval: 1,
      stopOnTerminate: false,
      enableHeadless: true,
      requiresBatteryNotLow: false,
      requiresCharging: false,
      requiresStorageNotLow: false,
      requiresDeviceIdle: false,
      requiredNetworkType: NetworkType.NONE,
    ),
    backgroundFetchHeadlessTask,
  ).then((int status) {
    JHLogger.$.e('[BackgroundFetch] Headless task timed-out- $status');
  }).catchError((e) {
    JHLogger.$.d("[BackgroundFetch] configure ERROR: $e");
  });
}
