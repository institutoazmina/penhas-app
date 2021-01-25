import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/usecases/birthday.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cpf.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';
import 'package:penhas/app/features/authentication/domain/usecases/genre.dart';
import 'package:penhas/app/features/authentication/domain/usecases/human_race.dart';
import 'package:penhas/app/features/authentication/domain/usecases/nickname.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

abstract class IUserRegisterRepository {
  Future<Either<Failure, SessionEntity>> signup({
    @required EmailAddress emailAddress,
    @required SignUpPassword password,
    @required Cep cep,
    @required Cpf cpf,
    @required Fullname fullname,
    @required Fullname socialName,
    @required Nickname nickName,
    @required Birthday birthday,
    @required Genre genre,
    @required HumanRace race,
  });

  Future<Either<Failure, ValidField>> checkField({
    EmailAddress emailAddress,
    SignUpPassword password,
    Cep cep,
    Cpf cpf,
    Fullname fullname,
    Fullname socialName,
    Nickname nickName,
    Birthday birthday,
    Genre genre,
    HumanRace race,
  });
}
