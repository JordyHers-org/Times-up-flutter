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
