//
import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/services.dart';

/// Custom Exception for the plugin,
/// thrown whenever the plugin is used on platforms other than Android
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
  late Duration _usage;
  DateTime _startDate, _endDate;

  AppUsageInfo(
    String name,
    double usageInSeconds,
    this._startDate,
    this._endDate,
  ) {
    var tokens = name.split('.');
    _packageName = name;
    _appName = tokens.last;
    _usage = Duration(seconds: usageInSeconds.toInt());
  }

  factory AppUsageInfo.fromMap(Map<String, dynamic> data) => AppUsageInfo(
        data['appName'],
        data['usageInSeconds'],
        data['startDate'],
        data['endDate'],
      );

  Map<String, dynamic> toMap() => {
        'appName': _appName,
        'usage': _usage.toString(),
        'startDate': _startDate,
        'endDate': _endDate,
      };

  /// The name of the application
  String get appName => _appName;

  /// The name of the application package
  String get packageName => _packageName;

  /// The amount of time the application has been used
  /// in the specified interval
  Duration get usage => _usage;

  /// The start of the interval
  DateTime get startDate => _startDate;

  /// The end of the interval
  DateTime get endDate => _endDate;

  @override
  String toString() {
    return 'App Usage: $packageName - $appName, duration: $usage [$startDate, $endDate]';
  }
}

class AppUsage {
  static const MethodChannel _methodChannel =
      MethodChannel('app_usage.methodChannel');

  static Future<List<AppUsageInfo>> getAppUsage(
    DateTime startDate,
    DateTime endDate,
  ) async {
    if (Platform.isAndroid) {
      /// Convert dates to ms since epoch
      var end = endDate.millisecondsSinceEpoch;
      var start = startDate.millisecondsSinceEpoch;

      /// Set parameters
      var interval = <String, int>{'start': start, 'end': end};

      /// Get result and parse it as a Map of <String, double>
      var usage = await _methodChannel.invokeMethod('getUsage', interval);
      var _map = Map<String, double>.from(usage);

      /// Convert each entry in the map to an Application object
      return _map.keys
          .map((k) => AppUsageInfo(k, _map[k]!, startDate, endDate))
          .where((a) => a.usage > Duration(seconds: 0))
          .toList();
    }
    throw AppUsageException('AppUsage API exclusively available on Android!');
  }
}
