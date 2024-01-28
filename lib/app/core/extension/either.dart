import 'package:dartz/dartz.dart';

import '../../shared/logger/log.dart';

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
