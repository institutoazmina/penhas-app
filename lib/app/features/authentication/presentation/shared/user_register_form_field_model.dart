import '../../domain/usecases/birthday.dart';
import '../../domain/usecases/cep.dart';
import '../../domain/usecases/cpf.dart';
import '../../domain/usecases/email_address.dart';
import '../../domain/usecases/full_name.dart';
import '../../domain/usecases/genre.dart';
import '../../domain/usecases/human_race.dart';
import '../../domain/usecases/nickname.dart';
import '../../domain/usecases/sign_up_password.dart';

class UserRegisterFormFieldModel {
  Fullname? fullname;
  Birthday? birthday;
  Cpf? cpf;
  Cep? cep;
  Nickname? nickname;
  Fullname? socialName;
  EmailAddress? emailAddress;
  Genre? genre;
  HumanRace? race;
  SignUpPassword? password;
  String? passwordConfirmation;
  String? token;

  String get validateFullName =>
      fullname == null ? Fullname('').mapFailure : fullname!.mapFailure;

  String get validateBirthday =>
      birthday == null ? Birthday('').mapFailure : birthday!.mapFailure;

  String get validateCpf => cpf == null ? Cpf('').mapFailure : cpf!.mapFailure;

  String get validateCep => cep == null ? Cep('').mapFailure : cep!.mapFailure;

  String get validateEmailAddress => emailAddress == null
      ? EmailAddress('').mapFailure
      : emailAddress!.mapFailure;

  String get validateNickname =>
      nickname == null ? Nickname('').mapFailure : nickname!.mapFailure;

  String get validateSocialName {
    if (genre == null || genre == Genre.female || genre == Genre.male) {
      return '';
    }

    return socialName == null ? Fullname('').mapFailure : fullname!.mapFailure;
  }

  String get validatePasswordConfirmation =>
      password!.rawValue == passwordConfirmation
          ? ''
          : 'As senhas não são iguais';
}
