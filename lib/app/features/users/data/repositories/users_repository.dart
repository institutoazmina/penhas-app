import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../authentication/presentation/shared/map_exception_to_failure.dart';
import '../models/user_detail_model.dart';
import '../models/user_search_session_model.dart';
import '../../domain/entities/user_detail_entity.dart';
import '../../domain/entities/user_search_options.dart';
import '../../domain/entities/user_search_session_entity.dart';
import '../../../../shared/logger/log.dart';

abstract class IUsersRepository {
  Future<Either<Failure, UserDetailEntity>> profileDetail(String clientId);
  Future<Either<Failure, UserSearchSessionEntity>> search(
    UserSearchOptions option,
  );
  Future<Either<Failure, void>> report(int clientId, String reason);
  Future<Either<Failure, void>> block(int clientId);
}

class UsersRepository implements IUsersRepository {
  UsersRepository({
    required IApiProvider? apiProvider,
  }) : _apiProvider = apiProvider;

  final IApiProvider? _apiProvider;

  @override
  Future<Either<Failure, UserDetailEntity>> profileDetail(
    String clientId,
  ) async {
    const endPoint = '/profile';
    final parameters = {'cliente_id': clientId};

    try {
      final response = await _apiProvider!
          .get(path: endPoint, parameters: parameters)
          .parseDetail();
      return right(response);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, UserSearchSessionEntity>> search(
    UserSearchOptions option,
  ) async {
    const endPoint = '/search-users';
    final skills = (option.skills != null && option.skills!.isNotEmpty)
        ? option.skills!.join(',')
        : null;
    final parameters = {
      'name': option.name,
      'skills': skills,
      'rows': option.rows?.toString() ?? '100',
      'next_page': option.nextPage,
    };

    try {
      final response = await _apiProvider!
          .get(path: endPoint, parameters: parameters)
          .parseSearchSession();
      return right(response);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, void>> report(int clientId, String reason) async {
    try {
      final endPoint = '/profile/$clientId/report';
      final body = {'reason': reason};
      await _apiProvider!.post(path: endPoint, body: body.toString());
      return right(null);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, void>> block(int clientId) async {
    try {
      final endPoint = '/profile/$clientId/block';
      await _apiProvider!.post(path: endPoint);
      return right(null);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }
}

extension _FutureExtension<T extends String> on Future<T> {
  Future<UserDetailEntity> parseDetail() async {
    return then((data) async {
      final jsonData = jsonDecode(data) as Map<String, dynamic>;
      return UserDetailModel.fromJson(jsonData);
    });
  }

  Future<UserSearchSessionEntity> parseSearchSession() async {
    return then((v) => jsonDecode(v) as Map<String, dynamic>)
        .then((v) => UserSearchSessionModel.fromJson(v));
  }
}
