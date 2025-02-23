import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/api_provider_error_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_server_configure.dart';
import '../../../../shared/logger/log.dart';
import '../../domain/entities/reset_password_response_entity.dart';
import '../../domain/repositories/i_reset_password_repository.dart';
import '../../domain/usecases/email_address.dart';
import '../../domain/usecases/sign_up_password.dart';
import '../models/password_reset_response_model.dart';

class ChangePasswordRepository
    implements IResetPasswordRepository, IChangePasswordRepository {
  ChangePasswordRepository({
    required IApiProvider apiProvider,
    required IApiServerConfigure serverConfiguration,
  })  : _apiProvider = apiProvider,
        _serverConfiguration = serverConfiguration;

  final IApiProvider _apiProvider;
  final IApiServerConfigure _serverConfiguration;
  @override
  Future<Either<Failure, ResetPasswordResponseEntity>> request({
    required EmailAddress emailAddress,
  }) async {
    try {
      final userAgent = await _serverConfiguration.userAgent;
      final response = await _apiProvider
          .post(
            path: '/reset-password/request-new',
            parameters: {
              'email': emailAddress.rawValue,
              'app_version': userAgent,
            },
          )
          .then((value) => jsonDecode(value))
          .then((value) => PasswordResetResponseModel.fromJson(value));

      return right(response);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, ValidField>> reset({
    required EmailAddress emailAddress,
    required SignUpPassword password,
    required String resetToken,
  }) async {
    try {
      final userAgent = await _serverConfiguration.userAgent;
      final response = await _apiProvider
          .post(
            path: '/reset-password/write-new',
            parameters: {
              'dry': '0',
              'email': emailAddress.rawValue,
              'senha': password.rawValue,
              'token': resetToken,
              'app_version': userAgent,
            },
          )
          .then((value) => jsonDecode(value))
          .then((value) => ValidField.fromJson(value));

      return right(response);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, ValidField>> validToken({
    required EmailAddress emailAddress,
    required String resetToken,
  }) async {
    try {
      final userAgent = await _serverConfiguration.userAgent;
      final response = await _apiProvider
          .post(
            path: '/reset-password/write-new',
            parameters: {
              'dry': '1',
              'email': emailAddress.rawValue,
              'token': resetToken,
              'app_version': userAgent,
            },
          )
          .then((value) => jsonDecode(value))
          .then((value) => ValidField.fromJson(value));

      return right(response);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }
}
