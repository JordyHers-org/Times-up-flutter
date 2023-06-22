import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/services.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:parental_control/app/helpers/parsing_extension.dart';

class AppUsageException implements Exception {
  final String _cause;

  AppUsageException(this._cause);

  @override
  String toString() {
    return 'ERROR : _$_cause';
  }
}

class AppUsageInfo {
  late String _packageName, _appName;
  late Uint8List? _appIcon;
  late Duration _usage;
  var _startDate, _endDate;

  AppUsageInfo(
    String name,
    double usageInSeconds,
    this._startDate,
    this._endDate, {
    Uint8List? appIcon,
  }) {
    var tokens = name.split('.');
    _packageName = name;
    _appName = tokens.last;
    _usage = Duration(seconds: usageInSeconds.toInt());
    _appIcon = appIcon;
  }

  factory AppUsageInfo.fromMap(Map<String, dynamic> data) => AppUsageInfo(
        data['appName'],
        data['usage'].toString().p(),
        data['startDate'],
        data['endDate'],
        appIcon: base64Decode(data['appIcon'] ?? ''),
      );

  Map<String, dynamic> toMap() => {
        'appName': _appName,
        'usage': _usage.toString(),
        'startDate': _startDate,
        'endDate': _endDate,
        'appIcon': base64Encode(_appIcon!),
      };

  String get appName => _appName;

  String get packageName => _packageName;

  Duration get usage => _usage;

  DateTime get startDate => _startDate;

  DateTime get endDate => _endDate;

  Uint8List? get appIcon => _appIcon;

  @override
  String toString() {
    return 'App Usage: $packageName - $appName, '
        'duration: $usage [${startDate}, $endDate]';
  }
}

class AppUsage {
  static const MethodChannel _methodChannel =
      MethodChannel('app_usage.methodChannel');

  static Future<List<AppUsageInfo>> getAppUsage(
    DateTime startDate,
    DateTime endDate, {
    required bool useMock,
  }) async {
    if (Platform.isAndroid || useMock) {
      var end = endDate.millisecondsSinceEpoch;
      var start = startDate.millisecondsSinceEpoch;
      var interval = <String, int>{'start': start, 'end': end};
      var usage = await _methodChannel.invokeMethod('getUsage', interval);
      var _appInfo = await InstalledApps.getInstalledApps(
        true,
        true,
      );

      var result = <AppUsageInfo>[];
      var listApps = <AppUsageInfo>[];

      for (String key in usage.keys) {
        var temp = List<double>.from(usage[key]);
        if (temp[0] > 0) {
          result.add(
            AppUsageInfo(
              key,
              temp[0],
              DateTime.fromMillisecondsSinceEpoch(temp[1].round() * 1000),
              DateTime.fromMillisecondsSinceEpoch(temp[2].round() * 1000),
            ),
          );
        }
      }

      for (var app in _appInfo) {
        for (var element in result) {
          if (element.packageName.contains(app.packageName!)) {
            listApps.add(
              AppUsageInfo(
                app.name!,
                element.usage.inMilliseconds.toDouble(),
                element.startDate,
                element.endDate,
                appIcon: app.icon!,
              ),
            );
          }
        }
      }

      return listApps;
    }
    throw AppUsageException('AppUsage API exclusively available on Android!');
  }
}
