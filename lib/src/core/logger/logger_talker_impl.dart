import 'package:talker_flutter/talker_flutter.dart';

import 'logger.dart';

class LoggerTalkerImpl implements Logger {
  factory LoggerTalkerImpl() {
    if (_instance == null) {
      _instance = LoggerTalkerImpl._internal();
      _talker = TalkerFlutter.init();
    }
    return _instance!;
  }

  LoggerTalkerImpl._internal();

  static LoggerTalkerImpl? _instance;

  static late final Talker _talker;

  final _appendedMessages = <dynamic>[];

  @override
  void append(dynamic message) {
    _appendedMessages.add(message);
  }

  @override
  void closeAppend() {
    info(_appendedMessages.join('\n'));
    _appendedMessages.clear();
  }

  @override
  void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _talker.debug(message, error, stackTrace);
  }

  @override
  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _talker.error(message, error, stackTrace);
  }

  @override
  void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _talker.info(message, error, stackTrace);
  }

  @override
  void warning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _talker.warning(message, error, stackTrace);
  }
}
