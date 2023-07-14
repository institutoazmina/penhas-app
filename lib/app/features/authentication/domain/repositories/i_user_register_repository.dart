import 'package:dartz/dartz.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/failures.dart';
import '../entities/session_entity.dart';
import '../usecases/birthday.dart';
import '../usecases/cep.dart';
import '../usecases/cpf.dart';
import '../usecases/email_address.dart';
import '../usecases/full_name.dart';
import '../usecases/genre.dart';
import '../usecases/human_race.dart';
import '../usecases/nickname.dart';
import '../usecases/sign_up_password.dart';

abstract class IUserRegisterRepository {
  Future<Either<Failure, SessionEntity>> signup({
    required EmailAddress? emailAddress,
    required SignUpPassword? password,
    required Cep? cep,
    required Cpf? cpf,
    required Fullname? fullname,
    required Fullname? socialName,
    required Nickname? nickName,
    required Birthday? birthday,
    required Genre? genre,
    required HumanRace? race,
  });

  Future<Either<Failure, ValidField>> checkField({
    EmailAddress? emailAddress,
    SignUpPassword? password,
    Cep? cep,
    Cpf? cpf,
    Fullname? fullname,
    Fullname? socialName,
    Nickname? nickName,
    Birthday? birthday,
    Genre? genre,
    HumanRace? race,
  });
}
