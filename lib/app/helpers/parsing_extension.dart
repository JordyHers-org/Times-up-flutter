extension ParseResult on String {
  String t() {
    var removeColon = replaceAll(':', ' ');
    var result = removeColon.replaceAll('.', '');

    result = result.replaceRange(1, 1, ' day ');
    result = result.replaceRange(9, 9, ' hour ');
    result = result.replaceRange(18, null, ' minutes');

    if (result.contains('00 hour')) {
      result = result.replaceRange(0, 14, '');
      return result;
    } else if (result.contains('0 day')) {
      result = result.replaceRange(0, 5, '');
      return result;
    }
    return result;
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
