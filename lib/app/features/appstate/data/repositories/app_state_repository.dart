import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/error/api_provider_error_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/interfaces/api_content_type.dart';
import '../../../../shared/logger/log.dart';
import '../../domain/entities/app_state_entity.dart';
import '../../domain/entities/update_user_profile_entity.dart';
import '../../domain/repositories/i_app_state_repository.dart';
import '../model/app_state_model.dart';

class AppStateRepository implements IAppStateRepository {
  AppStateRepository({
    required IApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  final IApiProvider _apiProvider;

  @override
  Future<Either<Failure, AppStateEntity>> check() async {
    try {
      final appState = await _apiProvider
          .get(
            path: '/me',
            contentType: ApiContentType.json,
          )
          .then((value) => jsonDecode(value))
          .then((value) => AppStateModel.fromJson(value));

      return right(appState);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, AppStateEntity>> update(
    UpdateUserProfileEntity update,
  ) async {
    try {
      final parameters = {
        'apelido': update.nickName,
        'minibio': update.minibio,
        'skills': update.skills?.join(','),
        'senha_atual': update.oldPassword,
        'senha': update.newPassword,
        'email': update.email,
        'raca': update.race,
      }..removeWhere((key, value) => value == null);

      final appState = await _apiProvider
          .put(
            path: '/me',
            parameters: parameters,
            contentType: ApiContentType.formUrlEncoded,
          )
          .then((value) => jsonDecode(value))
          .then((value) => AppStateModel.fromJson(value));

      return right(appState);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }
}
