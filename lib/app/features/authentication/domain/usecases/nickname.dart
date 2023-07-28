import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import 'map_validator_failure.dart';

@immutable
class Nickname extends Equatable with MapValidatorFailure {
  factory Nickname(String? input) {
    return Nickname._(_validate(input));
  }

  Nickname._(this.value);

  final Either<Failure, String?> value;

  String? get rawValue => value.getOrElse(() => '');
  bool get isValid => value.isRight();

  @override
  List<Object?> get props => [value];

  @override
  bool get stringify => true;

  static Either<Failure, String> _validate(String? input) {
    if (input == null || input.isEmpty) {
      return left(NicknameInvalidFailure());
    }

    return right(input.trim());
  }

  @override
  String get mapFailure => value.fold(
        (failure) => 'Apelido inválido para o sistema',
        (r) => '',
      );
}
