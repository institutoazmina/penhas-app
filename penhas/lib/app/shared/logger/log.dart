import 'dart:developer' as dev;

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logging/logging.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:stack_trace/stack_trace.dart';

typedef T OnError<T>(Object exception, StackTrace? stack);

bool isCrashlitycsEnabled = true;

void logWarn(String message) {
  dev.log(message);
  if (isCrashlitycsEnabled) FirebaseCrashlytics.instance.log(message);
}

void logError(Object exception, [StackTrace? stack]) {
  if (exception is NonCriticalError) return;
  stack ??= StackTrace.current;
  dev.log(
    exception.toString(),
    level: Level.WARNING.value,
    error: exception,
    stackTrace: stack,
  );
  if (isCrashlitycsEnabled)
    FirebaseCrashlytics.instance.recordError(exception, stack);
}

OnError get catchErrorLogger {
  Trace currentTrace = Trace.current(1);
  return (Object exception, StackTrace? stackTrace) async {
    final trace = Trace.from(stackTrace ?? Trace.current());
    if (!trace.frames.contains(currentTrace.frames.first)) {
      stackTrace = Trace(trace.frames + currentTrace.frames).vmTrace;
    }
    logError(exception, stackTrace);
  };
}
