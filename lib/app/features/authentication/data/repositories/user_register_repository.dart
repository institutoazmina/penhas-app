import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/api_provider_error_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/managers/app_configuration.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_server_configure.dart';
import '../../../../shared/logger/log.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/repositories/i_user_register_repository.dart';
import '../../domain/usecases/birthday.dart';
import '../../domain/usecases/cep.dart';
import '../../domain/usecases/cpf.dart';
import '../../domain/usecases/email_address.dart';
import '../../domain/usecases/full_name.dart';
import '../../domain/usecases/genre.dart';
import '../../domain/usecases/human_race.dart';
import '../../domain/usecases/nickname.dart';
import '../../domain/usecases/sign_up_password.dart';
import '../models/session_model.dart';

class UserRegisterRepository implements IUserRegisterRepository {
  UserRegisterRepository({
    required IApiProvider apiProvider,
    required IAppConfiguration appConfiguration,
    required IApiServerConfigure serverConfigure,
  })  : _apiProvider = apiProvider,
        _appConfiguration = appConfiguration,
        _serverConfigure = serverConfigure;

  final IApiProvider _apiProvider;
  final IApiServerConfigure _serverConfigure;
  final IAppConfiguration _appConfiguration;
  @override
  Future<Either<Failure, ValidField>> checkField({
    EmailAddress? emailAddress,
    SignUpPassword? password,
    Cep? cep,
    Fullname? fullname,
    Cpf? cpf,
    HumanRace? race,
    Fullname? socialName,
    Nickname? nickName,
    Birthday? birthday,
    Genre? genre,
  }) async {
    try {
      Map<String, String?> queryParameters = await _buildParameters(
        true,
        emailAddress,
        password,
        cep,
        cpf,
        fullname,
        socialName,
        nickName,
        birthday,
        genre,
        race,
      );

      final result = await _apiProvider
          .post(
            path: '/signup',
            parameters: queryParameters,
          )
          .then((value) => jsonDecode(value))
          .then((value) => ValidField.fromJson(value));

      return right(result);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, SessionEntity>> signup({
    required EmailAddress? emailAddress,
    required SignUpPassword? password,
    required Cep? cep,
    required Fullname? fullname,
    required Cpf? cpf,
    required HumanRace? race,
    Fullname? socialName,
    required Nickname? nickName,
    required Birthday? birthday,
    required Genre? genre,
  }) async {
    try {
      Map<String, String?> queryParameters = await _buildParameters(
        false,
        emailAddress,
        password,
        cep,
        cpf,
        fullname,
        socialName,
        nickName,
        birthday,
        genre,
        race,
      );

      final result = await _apiProvider
          .post(
            path: '/signup',
            parameters: queryParameters,
          )
          .then((value) => jsonDecode(value))
          .then((value) => SessionModel.fromJson(value));

      await _appConfiguration.saveApiToken(token: result.sessionToken);

      return right(result);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }

  Future<Map<String, String?>> _buildParameters(
    bool isCheckField,
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
  ) async {
    final userAgent = await _serverConfigure.userAgent;
    final Map<String, String?> queryParameters = {
      'app_version': userAgent,
      'dry': isCheckField ? '1' : '0',
      'email': emailAddress?.rawValue,
      'senha': password?.rawValue,
      'cep': cep?.rawValue,
      'nome_completo': fullname?.rawValue,
      'nome_social': socialName?.rawValue,
      'apelido': nickName?.rawValue,
      'dt_nasc': birthday?.rawValue,
      'genero': genre?.rawValue,
      'raca': race?.rawValue,
      'cpf': cpf?.rawValue,
    }..removeWhere((k, v) => v == null);
    return queryParameters;
  }
}
