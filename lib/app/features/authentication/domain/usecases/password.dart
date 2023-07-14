import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'map_validator_failure.dart';
import 'password_validator.dart';

@immutable
abstract class Password extends Equatable with MapValidatorFailure {
  Either<PasswordRule, String?> get value;

  String? get rawValue => value.getOrElse(() => null);

  bool get isValid => value.isRight();

  @override
  List<Object?> get props => [value];

  @override
  bool get stringify => true;

  @override
  String get mapFailure => value.fold(
        (failure) => failure.message,
        (r) => '',
      );
}
