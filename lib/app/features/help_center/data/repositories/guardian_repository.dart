import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/entities/user_location.dart';
import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/api_provider_error_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/interfaces/api_content_type.dart';
import '../../../../shared/logger/log.dart';
import '../../domain/entities/guardian_session_entity.dart';
import '../models/alert_model.dart';
import '../models/guardian_session_model.dart';

abstract class IGuardianRepository {
  Future<Either<Failure, GuardianSessionEntity>> fetch();
  Future<Either<Failure, AlertModel>> create(GuardianContactEntity guardian);
  Future<Either<Failure, ValidField>> update(GuardianContactEntity guardian);
  Future<Either<Failure, ValidField>> delete(GuardianContactEntity guardian);
  Future<Either<Failure, AlertModel>> alert(UserLocationEntity location);
  Future<Either<Failure, ValidField>> callPolice();
}

@immutable
class GuardianRepository extends IGuardianRepository {
  GuardianRepository({required IApiProvider apiProvider})
      : _apiProvider = apiProvider;

  final IApiProvider _apiProvider;

  @override
  Future<Either<Failure, GuardianSessionEntity>> fetch() async {
    try {
      final session = await _apiProvider
          .get(
            path: '/me/guardioes',
            contentType: ApiContentType.json,
          )
          .then((value) => jsonDecode(value))
          .then((value) => GuardianSessionModel.fromJson(value));

      return right(session);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, AlertModel>> create(
    GuardianContactEntity guardian,
  ) async {
    try {
      final parameters = {
        'nome': guardian.name,
        'celular': guardian.mobile,
      };

      final alert = await _apiProvider
          .post(
            path: '/me/guardioes',
            parameters: parameters,
          )
          .then((value) => jsonDecode(value))
          .then((value) => AlertModel.fromJson(value));

      return right(alert);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, ValidField>> update(
    GuardianContactEntity guardian,
  ) async {
    try {
      final parameters = {'nome': guardian.name};

      final result = await _apiProvider
          .put(
            path: '/me/guardioes/${guardian.id}',
            parameters: parameters,
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
  Future<Either<Failure, ValidField>> delete(
    GuardianContactEntity guardian,
  ) async {
    try {
      final result = await _apiProvider
          .delete(
            path: '/me/guardioes/${guardian.id}',
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
  Future<Either<Failure, AlertModel>> alert(UserLocationEntity location) async {
    try {
      final parameters = {
        'gps_lat': location.latitude.toString(),
        'gps_long': location.longitude.toString()
      };

      final result = await _apiProvider
          .post(
            path: '/me/guardioes/alert',
            parameters: parameters,
          )
          .then((value) => jsonDecode(value))
          .then((value) => AlertModel.fromJson(value));
      return right(result);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, ValidField>> callPolice() async {
    try {
      final result = await _apiProvider
          .post(path: '/me/call-police-pressed')
          .then((value) => jsonDecode(value))
          .then((value) => ValidField.fromJson(value));
      return right(result);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }
}
