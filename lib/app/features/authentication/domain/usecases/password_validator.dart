import 'package:collection/collection.dart' show IterableExtension;
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class PasswordValidator {
  Either<PasswordRule, String?> validate(
    String? input,
    List<PasswordRule> rules,
  ) {
    final firstViolatedRule = rules.firstWhereOrNull(
      (rule) => !rule.apply(input),
    );
    return firstViolatedRule == null ? right(input) : left(firstViolatedRule);
  }
}

abstract class PasswordRule extends Equatable {
  String get message;

  bool apply(String? input);

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

class EmptyRule extends PasswordRule {
  @override
  String get message => '';

  @override
  bool apply(String? input) {
    return input != null && input.trim().isNotEmpty;
  }
}

class MinLengthRule extends PasswordRule {
  final int _minCharacters = 8;

  @override
  String get message =>
      'Senha precisa ter no mínimo $_minCharacters caracteres';

  @override
  bool apply(String? input) {
    return input!.length >= _minCharacters;
  }
}

class LettersRule extends PasswordRule {
  @override
  String get message => 'Senha precisa ter ao menos 1 letra';

  @override
  bool apply(String? input) {
    return input!.contains(RegExp('[A-Z]', caseSensitive: false));
  }
}

class NumbersRule extends PasswordRule {
  @override
  String get message => 'Senha precisa ter ao menos 1 número';

  @override
  bool apply(String? input) {
    return input!.contains(RegExp('[0-9]'));
  }
}

class SpecialCharactersRule extends PasswordRule {
  @override
  String get message => 'Senha precisa ter ao menos 1 caractere especial';

  @override
  bool apply(String? input) {
    return input!.contains(RegExp('[^0-9A-Z]', caseSensitive: false));
  }
}
