import 'package:mocktail/mocktail.dart';
import 'package:penhas/bootstrap/bootstrap.dart';
import 'package:penhas/bootstrap/impl/main_app_runner.dart';
import 'package:penhas/main.dart' as app;
import 'package:test/test.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeRunner());
  });

  test('application entry point should call Bootstrap with MainAppRunner', () {
    // arrange
    Bootstrap.instance = _MockBootstrap();
    when(() => Bootstrap.instance.withRunner(any()))
        .thenAnswer((_) => Future.value());

    // act
    app.main();

    // assert
    final verifier = verify(() => Bootstrap.instance.withRunner(captureAny()))
      ..called(1);
    expect(verifier.captured.first, isA<MainAppRunner>());
  });
}

class _MockBootstrap extends Mock implements Bootstrap {}

class _FakeRunner extends Fake implements Runner {}
