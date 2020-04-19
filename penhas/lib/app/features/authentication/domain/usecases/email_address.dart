import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';

@immutable
class EmailAddress extends Equatable {
  final Either<Failure, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(_validate(input));
  }

  const EmailAddress._(this.value);

  @override
  List<Object> get props => [value];

  static Either<Failure, String> _validate(String input) {
    if (input == null || input.isEmpty) {
      return left(EmailAddressInvalidFailure());
    }

    return right(input);
  }
}

class EmailAddressInvalidFailure extends Failure {}
