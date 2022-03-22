import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/map_validator_failure.dart';

@immutable
class Fullname extends Equatable with MapValidatorFailure {
  factory Fullname(String? input) {
    return Fullname._(_validate(input));
  }

  Fullname._(this.value);

  final Either<Failure, String?> value;

  String? get rawValue => value.getOrElse(() => '');
  bool get isValid => value.isRight();

  @override
  List<Object?> get props => [value];

  @override
  bool get stringify => true;

  static Either<Failure, String> _validate(String? input) {
    if (input == null || input.isEmpty) {
      return left(FullnameInvalidFailure());
    }

    return right(input.trim());
  }

  @override
  String get mapFailure => value.fold(
        (failure) => 'Nome inválido para o sistema',
        (r) => '',
      );
}
