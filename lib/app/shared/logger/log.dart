import 'dart:developer' as dev;

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../core/error/exceptions.dart';

typedef OnError<T> = T Function(Object exception, StackTrace? stack);

final logger = Logger('PenhaS');

void initLogger() {
  if (kDebugMode) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen(_DebugLogRecorder());
  } else {
    Logger.root.level = Level.SEVERE;
    Logger.root.onRecord.listen(_CrashlyticsLogRecorder());
  }
}

void logError(Object exception, [StackTrace? stack]) {
  stack ??= Trace.current(1).vmTrace;
  logger.severe(exception.toString(), exception, stack);
}

OnError get catchErrorLogger {
  final Trace currentTrace = Trace.current(1);
  return (Object exception, StackTrace? stackTrace) async {
    final trace = Trace.from(stackTrace ?? Trace.current());
    if (!trace.frames.contains(currentTrace.frames.first)) {
      stackTrace = Trace(trace.frames + currentTrace.frames).vmTrace;
    }
    logError(exception, stackTrace);
  };
}

class _CrashlyticsLogRecorder {
  void call(LogRecord record) {
    final error = record.level >= Level.SEVERE ? record.error : null;

    if (error != null && error is! NonCriticalError) {
      FirebaseCrashlytics.instance.recordError(
        error,
        record.stackTrace,
        reason: record.message,
        fatal: record.level == Level.SHOUT,
      );
    }
  }
}

class _DebugLogRecorder {
  void call(LogRecord record) {
    dev.log(
      record.message,
      level: record.level.value,
      name: record.loggerName,
      error: record.error,
      stackTrace: record.stackTrace,
    );

    final tag = record.level.name;
    final message = '[$tag] ${record.message}';

    if (record.level < Level.SEVERE) {
      return debugPrint(message);
    }

    final buffer = StringBuffer('\x1B[31m$message\x1B[0m\n');

    buffer.writeln(record.error ?? '');
    buffer.write(record.stackTrace ?? '');

    return debugPrint(buffer.toString());
  }
}
