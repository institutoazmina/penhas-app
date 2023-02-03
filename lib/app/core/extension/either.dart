import 'package:dartz/dartz.dart';

extension EitherExtension<L extends Object, R> on Either<L, R> {
  R get() => fold((l) => throw l, (r) => r);
}
