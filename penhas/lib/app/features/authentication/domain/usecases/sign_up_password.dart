import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';

@immutable
class SignUpPassword extends Password {
  final PasswordValidator _passwordValidator;
  final String? _input;

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
