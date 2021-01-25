import 'package:penhas/app/features/authentication/domain/usecases/birthday.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cpf.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';
import 'package:penhas/app/features/authentication/domain/usecases/genre.dart';
import 'package:penhas/app/features/authentication/domain/usecases/human_race.dart';
import 'package:penhas/app/features/authentication/domain/usecases/nickname.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

class UserRegisterFormFieldModel {
  Fullname fullname;
  Birthday birthday;
  Cpf cpf;
  Cep cep;
  Nickname nickname;
  Fullname socialName;
  EmailAddress emailAddress;
  Genre genre;
  HumanRace race;
  SignUpPassword password;
  String token;

  String get validateFullName =>
      fullname == null ? Fullname('').mapFailure : fullname.mapFailure;

  String get validateBirthday =>
      birthday == null ? Birthday('').mapFailure : birthday.mapFailure;

  String get validateCpf => cpf == null ? Cpf('').mapFailure : cpf.mapFailure;

  String get validateCep => cep == null ? Cep('').mapFailure : cep.mapFailure;

  String get validateEmailAddress => emailAddress == null
      ? EmailAddress('').mapFailure
      : emailAddress.mapFailure;

  String get validateNickname =>
      nickname == null ? Nickname('').mapFailure : nickname.mapFailure;

  String get validateSocialName {
    if (genre == null || genre == Genre.female || genre == Genre.male) {
      return '';
    }

    return socialName == null ? Fullname('').mapFailure : fullname.mapFailure;
  }
}
