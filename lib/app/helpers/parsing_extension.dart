import 'package:intl/intl.dart';
import 'package:times_up_flutter/common_widgets/show_logger.dart';

extension ParseResult on String {
  String t() {
    final parts = split(':');
    var days = 0;
    var hours = 0;
    var minutes = 0;

    if (parts.length == 3) {
      days = int.parse(parts[0]);
      hours = int.parse(parts[1]);
      minutes = int.parse(parts[2].split('.')[0]);
    } else if (parts.length == 2) {
      hours = int.parse(parts[0]);
      minutes = int.parse(parts[1].split('.')[0]);
    }

    final duration = Duration(days: days, hours: hours, minutes: minutes);
    var result = '';

    if (duration.inDays > 0) {
      result += '${duration.inDays}d ';
    }

    if (duration.inHours % 24 > 0) {
      result += '${duration.inHours % 24}h ';
    }

    if (duration.inMinutes % 60 > 0) {
      result += '${duration.inMinutes % 60}m';
    }

    if (duration.inDays == 7) {
      return '1 w';
    }

    if (duration.inDays > 30) {
      return '${duration.inDays % 30} months';
    }

    return result.trim();
  }
}

extension IsValidString on String {
  bool isValid(String? value) {
    if (value != null) {
      return value.isNotEmpty;
    }
    return false;
  }
}

extension TimeStringParsing on String {
  double p() {
    final timeComponents = split(':');

    final hours = int.parse(timeComponents[0]);
    final minutes = int.parse(timeComponents[1]);
    final seconds = double.parse(timeComponents[2]);

    final totalTimeInSeconds = hours * 3600 + minutes * 60 + seconds;

    return totalTimeInSeconds;
  }
}

String formatDateTime(DateTime dateTime) {
  final formatter = DateFormat('MMMM d');
  return ' Today, ${formatter.format(dateTime)}';
}

Duration sumDurations(List<Duration> durations) {
  return durations.reduce((value, element) => value + element);
}

Duration getMedian(List<Duration> durations) {
  if (durations.isEmpty) return const Duration(milliseconds: 1000);

  durations.sort();
  final length = durations.length;

  // ignore: use_is_even_rather_than_modulo
  if (length % 2 == 1) {
    return durations[length ~/ 2];
  } else {
    final firstDuration = durations[length ~/ 2];
    final secondDuration = durations[length ~/ 2 - 1];
    return Duration(
      milliseconds:
          (firstDuration.inMilliseconds + secondDuration.inMilliseconds) ~/ 2,
    );
  }
}

Duration calculateAverage(List<Duration> durations) {
  final totalDuration = durations.reduce((value, element) => value + element);
  final length = durations.length;

  return Duration(milliseconds: totalDuration.inMilliseconds ~/ length);
}

double calculatePercentage(Duration duration) {
  final value = duration.toString().replaceAll('.000000', '');
  final parts = value.split(':');

  final days = int.parse(parts[0]);
  final hours = int.parse(parts[1]);
  final minutes = int.parse(parts[2]);
  final parsedDuration = Duration(
    days: days,
    hours: hours,
    minutes: minutes,
  );
  var totalDuration = const Duration(days: 3, hours: 10);

  if (parsedDuration.inDays > 1000 && parsedDuration.inDays < 150000) {
    totalDuration = const Duration(days: 13000, hours: 2);
  }
  if (parsedDuration.inDays > 60 && parsedDuration.inDays < 100) {
    totalDuration = const Duration(days: 340, hours: 2);
  }
  if (parsedDuration.inDays > 30 && parsedDuration.inDays < 60) {
    totalDuration = const Duration(days: 240, hours: 2);
  }

  if (parsedDuration.inDays > 7 && parsedDuration.inDays < 30) {
    totalDuration = const Duration(days: 30, hours: 2);
  }

  final milliseconds = parsedDuration.inMilliseconds;
  final totalMilliseconds = totalDuration.inMilliseconds;

  final res = (milliseconds / totalMilliseconds) * 100;
  JHLogger.$.d(parsedDuration);
  return res;
}
