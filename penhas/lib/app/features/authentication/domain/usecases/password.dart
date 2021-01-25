import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'map_validator_failure.dart';

@immutable
class Password extends Equatable with MapValidatorFailure {
  final Either<PasswordRule, String> value;

  static final List<PasswordRule> _rules = [
    EmptyRule(),
    MinLengthRule(),
    LettersRule(),
    NumbersRule(),
    SpecialCharactersRule()
  ];

  String get rawValue => value.getOrElse(() => null);

  bool get isValid => value.isRight();

  factory Password(String input) {
    return Password._(_validate(input));
  }

  Password._(this.value);

  @override
  List<Object> get props => [value];

  @override
  bool get stringify => true;

  static Either<PasswordRule, String> _validate(String input) {
    final firstInvalidRule = _rules.firstWhere(
      (rule) => !rule.apply(input),
      orElse: () => null,
    );
    return firstInvalidRule == null ? right(input) : left(firstInvalidRule);
  }

  @override
  String get mapFailure => value.fold(
        (failure) => failure.message,
        (r) => '',
      );
}

abstract class PasswordRule extends Equatable {
  String get message;

  bool apply(String input);

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}

class EmptyRule extends PasswordRule {
  @override
  String get message =>
      'Informe uma senha com 8 caracters contendo letras, números e um caractere especial';

  @override
  bool apply(String input) {
    return input != null && input.trim().isNotEmpty;
  }
}

class MinLengthRule extends PasswordRule {
  final int _minCharacters = 8;

  @override
  String get message =>
      'Senha precisa ter no mínimo $_minCharacters caracteres';

  @override
  bool apply(String input) {
    return input.length >= _minCharacters;
  }
}

class LettersRule extends PasswordRule {
  @override
  String get message => 'Senha precisa ter ao menos 1 letra';

  @override
  bool apply(String input) {
    return input.contains(new RegExp(r'[aA-zZ]'));
  }
}

class NumbersRule extends PasswordRule {
  @override
  String get message => 'Senha precisa ter ao menos 1 número';

  @override
  bool apply(String input) {
    return input.contains(new RegExp(r'[0-9]'));
  }
}

class SpecialCharactersRule extends PasswordRule {
  @override
  String get message => 'Senha precisa ter ao menos 1 caractere especial';

  @override
  bool apply(String input) {
    return input.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }
}
