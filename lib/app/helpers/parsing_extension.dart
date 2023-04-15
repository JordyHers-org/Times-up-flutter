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
