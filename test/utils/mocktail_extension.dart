import 'package:dartz/dartz.dart';
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
