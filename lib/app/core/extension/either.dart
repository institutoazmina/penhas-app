import 'package:dartz/dartz.dart';

import '../../shared/logger/log.dart';
import '../error/failures.dart';

Either<L, R> success<L, R>(R r) => right(r);

Either<L, R> failure<L, R>(L l) => left(l);

extension EitherExtension<L extends Object, R> on Either<L, R> {
  /// Returns the value from the [Right] or throws an exception if the [Either]
  /// is a [Left].
  R get() => fold((l) => throw l, (r) => r);

  /// Returns true if the Either is a [Right] containing the given [value].
  /// Otherwise, returns false.
  ///
  /// This will log the error if the Either is a [Left].
  bool get isSuccess => fold(
        (l) {
          logError(l);
          return false;
        },
        (r) => true,
      );
}

extension EitherFuture<T extends Object?> on Future<T> {
  /// Converts a Future to an Either.
  /// If the Future completes successfully, the result will be a [Right].
  /// If the Future completes with an error, the result will be a [Left].
  Future<Either<Failure, T>> toEither() async {
    try {
      final result = await this;
      return result is Either<Failure, T>
          ? result as Either<Failure, T> // ignore: unnecessary_cast
          : right<Failure, T>(result);
    } catch (error, stackTrace) {
      logError(error, stackTrace);
      return left(error is Failure ? error : UnknownFailure());
    }
  }
}
