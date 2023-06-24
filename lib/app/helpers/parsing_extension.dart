import 'package:intl/intl.dart';
import 'package:parental_control/common_widgets/show_logger.dart';

extension ParseResult on String {
  String t() {
    var parts = split(':');
    var days = 0;
    var hours = 0;
    var minutes = 0;
    var seconds = 0;

    if (parts.length == 3) {
      days = int.parse(parts[0]);
      hours = int.parse(parts[1]);
      minutes = int.parse(parts[2].split('.')[0]);
    } else if (parts.length == 2) {
      hours = int.parse(parts[0]);
      minutes = int.parse(parts[1].split('.')[0]);
    }

    var duration =
        Duration(days: days, hours: hours, minutes: minutes, seconds: seconds);
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
    var timeComponents = split(':');

    var hours = int.parse(timeComponents[0]);
    var minutes = int.parse(timeComponents[1]);
    var seconds = double.parse(timeComponents[2]);

    var totalTimeInSeconds = hours * 3600 + minutes * 60 + seconds;

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
  durations.sort();
  var length = durations.length;

  if (length % 2 == 1) {
    return durations[length ~/ 2];
  } else {
    var firstDuration = durations[length ~/ 2];
    var secondDuration = durations[length ~/ 2 - 1];
    return Duration(
      milliseconds:
          (firstDuration.inMilliseconds + secondDuration.inMilliseconds) ~/ 2,
    );
  }
}

Duration calculateAverage(List<Duration> durations) {
  var totalDuration = durations.reduce((value, element) => value + element);
  var length = durations.length;

  return Duration(milliseconds: totalDuration.inMilliseconds ~/ length);
}

double calculatePercentage(Duration duration) {
  var value = duration.toString().replaceAll('.000000', '');
  var parts = value.split(':');
  var days = int.parse(parts[0]);
  var hours = int.parse(parts[1]);
  var minutes = int.parse(parts[2]);
  var parsedDuration = Duration(
    days: days,
    hours: hours,
    minutes: minutes,
  );

  final totalDuration = Duration(days: 30, hours: 2);
  final milliseconds = parsedDuration.inMilliseconds;
  final totalMilliseconds = totalDuration.inMilliseconds;

  var res = (milliseconds / totalMilliseconds) * 100;

  JHLogger.$.w(duration);
  JHLogger.$.w(res);
  return res;
}
