import 'dart:async' as async;
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';


class AppLog {
  AppLog._();

  static void e(Object error, StackTrace stackTrace, {Object? message}) {
    Logger.root
        .log(Level.SEVERE, message ?? error.toString(), error, stackTrace);
  }

  static void i(Object message) {
    Logger.root.info(message);
  }
}

void _debugLog(Object? object) {
  if (!kDebugMode) {
    return;
  }

  debugPrint(object?.toString());
}

typedef ReleaseModeExceptionLogger = void Function(
    Object error, StackTrace stackTrace, Object extra);

void Function(LogRecord) logListener({
  required ReleaseModeExceptionLogger onReleaseModeException,
}) {
  const List<Type> ignoreTypes = <Type>[
    io.SocketException,
    io.HandshakeException,
    async.TimeoutException,
  ];
  return (LogRecord record) {
    if (record.level != Level.SEVERE) {
      _debugLog(record.message);
      return;
    }

    _debugLog(record.error);
    _debugLog(record.stackTrace);

    if (kDebugMode || ignoreTypes.contains(record.error.runtimeType)) {
      return;
    }

    onReleaseModeException(record.error!, record.stackTrace!,
        record.object ?? <String, dynamic>{});
  };
}
