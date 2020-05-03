import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/authentication/data/datasources/user_register_data_source.dart';
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

class UserRegisterRepository implements IUserRegisterRepository {
  final IUserRegisterDataSource _dataSource;
  final INetworkInfo _networkInfo;

  factory UserRegisterRepository({
    @required IUserRegisterDataSource dataSource,
    @required INetworkInfo networkInfo,
  }) {
    return UserRegisterRepository._(dataSource, networkInfo);
  }

  const UserRegisterRepository._(this._dataSource, this._networkInfo);

  @override
  Future<Either<Failure, ValidField>> checkField({
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
    try {
      await _dataSource.checkField(
          emailAddress: emailAddress,
          password: password,
          cep: cep,
          cpf: cpf,
          fullname: fullname,
          nickName: nickName,
          birthday: birthday,
          genre: genre,
          race: race);

      return right(ValidField());
    } catch (e) {
      return left(await _handleError(e));
    }
  }

  @override
  Future<Either<Failure, SessionEntity>> signup({
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
    try {
      final session = await _dataSource.register(
          emailAddress: emailAddress,
          password: password,
          cep: cep,
          cpf: cpf,
          fullname: fullname,
          nickName: nickName,
          birthday: birthday,
          genre: genre,
          race: race);

      return right(SessionEntity(sessionToken: session.sessionToken));
    } catch (e) {
      return left(await _handleError(e));
    }
  }

  Future<Failure> _handleError(Object error) async {
    if (await _networkInfo.isConnected == false) {
      return InternetConnectionFailure();
    }

    if (error is ApiProviderException) {
      return ServerSideFormFieldValidationFailure(
          error: error.bodyContent['error'],
          field: error.bodyContent['field'],
          reason: error.bodyContent['reason'],
          message: error.bodyContent['message']);
    }

    return ServerFailure();
  }
}
