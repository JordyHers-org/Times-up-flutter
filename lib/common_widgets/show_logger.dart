import 'package:logger/logger.dart';

class JHLogger {
  static var $ = Logger(
    printer: PrettyPrinter(),
  );

  static var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );
}
