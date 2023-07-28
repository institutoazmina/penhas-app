import 'package:dartz/dartz.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_user_register_repository.dart';
import 'birthday.dart';
import 'cep.dart';
import 'cpf.dart';
import 'email_address.dart';
import 'full_name.dart';
import 'genre.dart';
import 'human_race.dart';
import 'nickname.dart';
import 'sign_up_password.dart';

class CheckRegisterField {
  CheckRegisterField(this.repository);

  final IUserRegisterRepository? repository;

  Future<Either<Failure, ValidField>> call({
    EmailAddress? emailAddress,
    SignUpPassword? password,
    Cep? cep,
    Cpf? cpf,
    Fullname? fullname,
    Nickname? nickName,
    Birthday? birthday,
    Genre? genre,
    HumanRace? race,
  }) async {
    if (emailAddress == null &&
        password == null &&
        cep == null &&
        cpf == null &&
        fullname == null &&
        nickName == null &&
        birthday == null &&
        genre == null &&
        race == null) {
      return left(RequiredParameter());
    }

    return repository!.checkField(
      emailAddress: emailAddress,
      password: password,
      cep: cep,
      cpf: cpf,
      fullname: fullname,
      nickName: nickName,
      birthday: birthday,
      race: race,
      genre: genre,
    );
  }
}
