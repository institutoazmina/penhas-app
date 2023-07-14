import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'password.dart';
import 'password_validator.dart';

@immutable
class SignUpPassword extends Password {
  SignUpPassword(this._input, this._passwordValidator);

  final PasswordValidator _passwordValidator;
  final String? _input;

  @override
  Either<PasswordRule, String?> get value =>
      _passwordValidator.validate(_input, [
        EmptyRule(),
        MinLengthRule(),
        LettersRule(),
        NumbersRule(),
        SpecialCharactersRule()
      ]);
}
