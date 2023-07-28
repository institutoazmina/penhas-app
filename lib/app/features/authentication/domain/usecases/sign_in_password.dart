import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'password.dart';
import 'password_validator.dart';

@immutable
class SignInPassword extends Password {
  SignInPassword(this._input, this._passwordValidator);

  final PasswordValidator _passwordValidator;
  final String? _input;

  @override
  Either<PasswordRule, String?> get value => _passwordValidator.validate(
        _input,
        [EmptyRule()],
      );
}
