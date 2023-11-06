import 'package:logger/logger.dart';

class JHLogger {
  static Logger $ = Logger(
    printer: PrettyPrinter(),
  );

  static Logger loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );
}
