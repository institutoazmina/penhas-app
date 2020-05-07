import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
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

class RegisterUser {
  final IUserRegisterRepository _repository;
  final IAppConfiguration _appConfiguration;

  factory RegisterUser({
    @required IUserRegisterRepository authenticationRepository,
    @required IAppConfiguration appConfiguration,
  }) {
    return RegisterUser._(
      authenticationRepository,
      appConfiguration,
    );
  }

  RegisterUser._(
    this._repository,
    this._appConfiguration,
  );

  Future<Either<Failure, SessionEntity>> call({
    @required EmailAddress emailAddress,
    @required Password password,
    @required Cep cep,
    @required Cpf cpf,
    @required Fullname fullname,
    @required Nickname nickName,
    @required Birthday birthday,
    @required Genre genre,
    @required HumanRace race,
  }) async {
    final response = await _repository.signup(
        emailAddress: emailAddress,
        password: password,
        cep: cep,
        cpf: cpf,
        fullname: fullname,
        nickName: nickName,
        birthday: birthday,
        race: race,
        genre: genre);

    return response.fold<Future<Either<Failure, SessionEntity>>>(
      (failure) => Future.value(left(failure)),
      (session) => _saveAthenticationToken(session),
    );
  }

  Future<Either<Failure, SessionEntity>> _saveAthenticationToken(
      SessionEntity session) async {
    print(session.sessionToken);
    await _appConfiguration.saveApiToken(token: session.sessionToken);
    return Future.value(right(session));
  }
}
