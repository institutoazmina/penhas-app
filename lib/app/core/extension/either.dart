import 'package:dartz/dartz.dart';

extension EitherExtension<L extends Object, R> on Either<L, R> {
  R? getOrNull() => fold((l) => null, (r) => r);
  R get() => fold((l) => throw l, (r) => r);
}
