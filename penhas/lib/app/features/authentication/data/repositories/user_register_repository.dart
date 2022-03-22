import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
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
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';
import 'package:penhas/app/shared/logger/log.dart';

class UserRegisterRepository implements IUserRegisterRepository {
  UserRegisterRepository({
    required INetworkInfo? networkInfo,
    required IAppConfiguration? appConfiguration,
    required IUserRegisterDataSource? dataSource,
  })  : _dataSource = dataSource,
        _networkInfo = networkInfo,
        _appConfiguration = appConfiguration;

  final INetworkInfo? _networkInfo;
  final IUserRegisterDataSource? _dataSource;
  final IAppConfiguration? _appConfiguration;

  @override
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
  }) async {
    try {
      await _dataSource!.checkField(
        emailAddress: emailAddress,
        password: password,
        cep: cep,
        cpf: cpf,
        fullname: fullname,
        nickName: nickName,
        birthday: birthday,
        genre: genre,
        race: race,
      );

      return right(const ValidField());
    } catch (e, stack) {
      logError(e, stack);
      return left(await _handleError(e));
    }
  }

  @override
  Future<Either<Failure, SessionEntity>> signup({
    required EmailAddress? emailAddress,
    required SignUpPassword? password,
    required Cep? cep,
    required Cpf? cpf,
    required Fullname? fullname,
    Fullname? socialName,
    required Nickname? nickName,
    required Birthday? birthday,
    required Genre? genre,
    required HumanRace? race,
  }) async {
    try {
      final session = await _dataSource!.register(
        emailAddress: emailAddress,
        password: password,
        cep: cep,
        cpf: cpf,
        fullname: fullname,
        nickName: nickName,
        birthday: birthday,
        genre: genre,
        race: race,
        socialName: socialName,
      );

      await _appConfiguration!.saveApiToken(token: session.sessionToken);

      return right(
        SessionEntity(
          sessionToken: session.sessionToken,
          deletedScheduled: session.deletedScheduled,
        ),
      );
    } catch (e, stack) {
      logError(e, stack);
      return left(await _handleError(e));
    }
  }

  Future<Failure> _handleError(Object error) async {
    if (await _networkInfo!.isConnected == false) {
      return InternetConnectionFailure();
    }

    if (error is ApiProviderException) {
      return ServerSideFormFieldValidationFailure(
        error: error.bodyContent['error'],
        field: error.bodyContent['field'],
        reason: error.bodyContent['reason'],
        message: error.bodyContent['message'],
      );
    }

    return ServerFailure();
  }
}
