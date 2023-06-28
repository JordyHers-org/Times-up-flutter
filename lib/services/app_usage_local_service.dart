import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:times_up_flutter/app/helpers/parsing_extension.dart';

class AppUsageException implements Exception {
  AppUsageException(this._cause);
  final String _cause;

  @override
  String toString() {
    return 'ERROR : _$_cause';
  }
}

class AppUsageInfo {
  AppUsageInfo(
    String name,
    double usageInSeconds,
    this._startDate,
    this._endDate, {
    Uint8List? appIcon,
  }) {
    final tokens = name.split('.');
    _packageName = name;
    _appName = tokens.last;
    _usage = Duration(seconds: usageInSeconds.toInt());
    _appIcon = appIcon;
  }

  factory AppUsageInfo.fromMap(Map<String, dynamic> data) => AppUsageInfo(
        data['appName'] as String,
        data['usage'].toString().p(),
        data['startDate'] as DateTime,
        data['endDate'] as DateTime,
        appIcon: base64Decode(data['appIcon'] as String),
      );
  late String _packageName, _appName;
  late Uint8List? _appIcon;
  late Duration _usage;
  DateTime _startDate, _endDate;

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
        'duration: $usage [${Timestamp.fromDate(startDate)},'
        ' ${Timestamp.fromDate(endDate)}]';
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
      final end = endDate.millisecondsSinceEpoch;
      final start = startDate.millisecondsSinceEpoch;
      final interval = <String, int>{'start': start, 'end': end};
      final usage = await _methodChannel.invokeMethod('getUsage', interval)
          as Map<dynamic, dynamic>;
      final appInfo = await InstalledApps.getInstalledApps(
        true,
        true,
      );

      final result = <AppUsageInfo>[];
      final listApps = <AppUsageInfo>[];

      for (final key in usage.keys) {
        final temp = List<double>.from(usage[key] as Iterable<dynamic>);
        if (temp[0] > 0) {
          result.add(
            AppUsageInfo(
              key.toString(),
              temp[0],
              DateTime.fromMillisecondsSinceEpoch(temp[1].round() * 1000),
              DateTime.fromMillisecondsSinceEpoch(temp[2].round() * 1000),
            ),
          );
        }
      }

      for (final app in appInfo) {
        for (final element in result) {
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
