import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/birthday.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cpf.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';
import 'package:penhas/app/features/authentication/domain/usecases/genre.dart';
import 'package:penhas/app/features/authentication/domain/usecases/human_race.dart';
import 'package:penhas/app/features/authentication/domain/usecases/nickname.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

class CheckRegisterField {
  final IUserRegisterRepository repository;

  CheckRegisterField(this.repository);

  Future<Either<Failure, ValidField>> call({
    EmailAddress emailAddress,
    Password password,
    Cep cep,
    Cpf cpf,
    Fullname fullname,
    Nickname nickName,
    Birthday birthday,
    Genre genre,
    HumanRace race,
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

    return repository.checkField(
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
