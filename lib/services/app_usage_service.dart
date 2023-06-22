import 'package:flutter/cupertino.dart';
import 'package:installed_apps/app_info.dart';
import 'package:parental_control/app/helpers/parsing_extension.dart';
import 'package:parental_control/common_widgets/show_logger.dart';
import 'package:parental_control/models/child_model/child_model.dart';
import 'package:parental_control/services/app_usage_local_service.dart';
import 'package:parental_control/services/database.dart';

abstract class AppService {
  Future<void> getAppUsageService();
  Future<Duration?> getChildrenAppUsageAverage(Database database);
  Future<Duration?> getChildAppUsagePerDay(BuildContext context);
}

class AppUsageService implements AppService {
  List<AppUsageInfo> _info = <AppUsageInfo>[];
  List<AppInfo> _appInfo = <AppInfo>[];
  Duration _averageDuration = Duration(minutes: 1);

  List<AppUsageInfo> get info => _info;
  List<AppInfo> get appInfo => _appInfo;
  Duration get averageDuration => _averageDuration;

  @override
  Future<void> getAppUsageService() async {
    try {
      var endDate = DateTime.now();
      var startDate = endDate.subtract(Duration(hours: 1));
      var infoList =
          await AppUsage.getAppUsage(startDate, endDate, useMock: false);
      _info = infoList;
    } on AppUsageException catch (exception) {
      JHLogger.$.e(exception);
    }
  }

  @override
  Future<Duration?> getChildrenAppUsageAverage(Database database) async {
    var _children = <ChildModel>[];
    var _durations = <Duration>[];
    try {
      var response = await database.childrenStream().first;
      if (response.isNotEmpty) {
        _children = response.toList();

        for (var listUsage in _children) {
          for (var usage in listUsage.appsUsageModel) {
            _durations.add(usage.usage);
          }
        }
        var averageDuration = getMedian(_durations);
        JHLogger.$.e(averageDuration);
        _averageDuration = averageDuration;
        return averageDuration;
      }
    } on AppUsageException catch (exception) {
      JHLogger.$.e(exception);
    }

    return null;
  }

  @override
  Future<Duration?> getChildAppUsagePerDay(BuildContext context) async {
    try {
      var endDate = DateTime.now();
      var startDate = endDate.subtract(Duration(hours: 1));
      var infoList =
          await AppUsage.getAppUsage(startDate, endDate, useMock: false);
      _info = infoList;
    } on AppUsageException catch (exception) {
      JHLogger.$.e(exception);
    }

    return null;
  }
}
