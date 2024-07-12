import 'package:logger/logger.dart';

class Log {
  static const bool _enabled = false;
  static final Logger _logger = Logger(
    filter: DevelopmentFilter(),
    printer: PrettyPrinter(),
    output: ConsoleOutput(),
  );

  static void d(dynamic message) {
    if (_enabled) {
      _logger.d(message);
    }
  }

  static void e(dynamic message) {
    if (_enabled) {
      _logger.e(message);
    }
  }

  static void i(dynamic message) {
    if (_enabled) {
      _logger.i(message);
    }
  }

  static void w(dynamic message) {
    if (_enabled) {
      _logger.w(message);
    }
  }

  static void t(dynamic message) {
    if (_enabled) {
      _logger.t(message);
    }
  }

  static void f(dynamic message) {
    if (_enabled) {
      _logger.f(message);
    }
  }
}
