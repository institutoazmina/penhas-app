import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/extension/either.dart';

///
/// Utils para Either
///
Future<Either<F, S>> successFuture<F, S>(S result) =>
    Future.value(success(result));

Future<Either<F, S>> failFuture<F, S>(F fail) => Future.value(failure(fail));

///
/// Mocktail
///
extension MocktailWhenEither<T, L, R> on When<Future<Either<L, R>>> {
  void thenSuccess(R Function(Invocation) success) =>
      thenAnswer((invocation) => successFuture(success(invocation)));

  void thenFailure(L Function(Invocation) failure) =>
      thenAnswer((invocation) => failFuture(failure(invocation)));
}

///
///
///
Future<void> preparePageTests(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await loadAppFonts();

  const isCi = bool.fromEnvironment('isCI');

  return AlchemistConfig.runWithConfig(
    config: const AlchemistConfig(
      platformGoldensConfig: PlatformGoldensConfig(
        enabled: !isCi,
      ),
    ),
    run: () async {
      return testMain();
    },
  );
}
