import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/impl/background_task_manager.dart';
import 'package:penhas/bootstrap/bootstrap.dart';
import 'package:penhas/bootstrap/impl/background_tasks_runner.dart';
import 'package:penhas/bootstrap/impl/main_app_runner.dart';
import 'package:penhas/main.dart' as app;

void main() {
  late Bootstrap mockBootstrap;
  late BackgroundTaskManager mockBackgroundTaskManager;

  setUpAll(() {
    registerFallbackValue(_FakeRunner());
  });

  setUp(() {
    mockBootstrap = _MockBootstrap();
    mockBackgroundTaskManager = _MockBackgroundTaskManager();

    Bootstrap.instance = mockBootstrap;
    BackgroundTaskManager.instance = mockBackgroundTaskManager;
  });

  group('main', () {
    test(
      'should call Bootstrap with MainAppRunner',
      skip: true,
      () {
        // arrange
        when(
          () => mockBootstrap.withRunner(
            any(),
            onBeforeRun: any(named: 'onBeforeRun'),
          ),
        ).thenAnswer((invoke) async {
          final onBeforeRun = invoke.namedArguments[#onBeforeRun] as Function;
          await onBeforeRun();
        });

        // act
        app.main();

        // assert
        final verifier = verify(
          () => Bootstrap.instance.withRunner(
            captureAny(),
            onBeforeRun: any(named: 'onBeforeRun'),
          ),
        )..called(1);
        expect(verifier.captured.first, isA<MainAppRunner>());
        verify(
          () => mockBackgroundTaskManager
              .registerDispatcher(app.callbackDispatcher),
        ).called(1);
      },
    );
  });

  group('callbackDispatcher', () {
    test(
      'should call Bootstrap with BackgroundTasksRunner',
      () {
        // arrange
        when(() => Bootstrap.instance.withRunner(any()))
            .thenAnswer((_) => Future.value());

        // act
        app.callbackDispatcher();

        // assert
        final verifier = verify(
          () => Bootstrap.instance.withRunner(captureAny()),
        )..called(1);
        expect(verifier.captured.first, isA<BackgroundTasksRunner>());
      },
    );
  });
}

class _MockBootstrap extends Mock implements Bootstrap {}

class _MockBackgroundTaskManager extends Mock
    implements BackgroundTaskManager {}

class _FakeRunner extends Fake implements Runner {}
