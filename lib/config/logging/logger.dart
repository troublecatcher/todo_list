import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(
    filter: DevelopmentFilter(),
    printer: PrettyPrinter(),
    output: ConsoleOutput(),
  );

  static void d(dynamic message) => _logger.d(message);

  static void e(dynamic message) => _logger.e(message);

  static void i(dynamic message) => _logger.i(message);

  static void w(dynamic message) => _logger.w(message);

  static void t(dynamic message) => _logger.t(message);

  static void f(dynamic message) => _logger.f(message);
}
