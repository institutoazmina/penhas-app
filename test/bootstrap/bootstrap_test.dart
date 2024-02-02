import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/bootstrap/bootstrap.dart';

import '../utils/mock_callbacks.dart';
import '../utils/test_utils.dart';

void main() {
  group(Bootstrap, () {
    late Bootstrap sut;

    late Logger mockLogger;
    late Runner mockRunner;
    late VoidCallback onBeforeRun;

    setUpAll(() {
      registerFallbackValue(_FakeLogRecord());
    });

    setUp(() {
      mockLogger = _MockLogger();
      mockRunner = _MockRunner();
      onBeforeRun = MockVoidCallback();

      sut = Bootstrap(mockLogger);
    });

    group('withRunner', () {
      test(
        'should initialize, configure, and run the application',
        () async {
          // act
          await sut.withRunner(
            mockRunner,
            onBeforeRun: onBeforeRun,
          );

          // assert
          verifyInOrder([
            () => mockRunner.initialize(),
            () => mockRunner.configure(),
            () => onBeforeRun(),
            () => mockRunner.run(),
          ]);
          verifyNoMoreInteractions(mockRunner);
          verifyNoMoreInteractions(onBeforeRun);
        },
      );

      parameterizedGroup<Function>(
        'should handle uncaught errors',
        () => {
          'configure': () => mockRunner.configure(),
          'onBeforeRun': () => onBeforeRun(),
          'run': () => mockRunner.run(),
        },
        (name, item) {
          test(
            'when $name throws an error',
            () async {
              // // arrange
              final completer = Completer<void>();
              when(() => item()).thenThrow(Exception('Uncaught error'));
              when(() => mockLogger.shout(any(), any(), any()))
                  .thenAnswer((invocation) => completer.complete());

              // // act
              sut.withRunner(
                mockRunner,
                onBeforeRun: onBeforeRun,
              );
              await completer.future;

              // // assert
              verify(() => mockRunner.initialize()).called(1);
              verify(() => mockLogger.shout(any(), any(), any())).called(1);
            },
          );
        },
      );
    });
  });
}

class _MockRunner extends Mock implements Runner {}

class _MockLogger extends Mock implements Logger {}

class _FakeLogRecord extends Fake implements LogRecord {}
