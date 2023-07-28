import 'package:dartz/dartz.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import 'map_validator_failure.dart';

@immutable
class EmailAddress extends Equatable with MapValidatorFailure {
  factory EmailAddress(String? input) {
    return EmailAddress._(_validate(input));
  }

  EmailAddress._(this.value);

  final Either<Failure, String?> value;

  String? get rawValue => value.getOrElse(() => '');
  bool get isValid => value.isRight();

  @override
  List<Object?> get props => [value];

  @override
  bool get stringify => true;

  static Either<Failure, String> _validate(String? input) {
    if (input == null || EmailValidator.validate(input) == false) {
      return left(EmailAddressInvalidFailure());
    }

    return right(input);
  }

  @override
  String get mapFailure => value.fold(
        (failure) => 'Endereço de email inválido',
        (r) => '',
      );
}
