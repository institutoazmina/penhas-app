import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_exception_to_failure.dart';
import 'package:penhas/app/features/users/data/models/user_detail_model.dart';
import 'package:penhas/app/features/users/data/models/user_search_session_model.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_entity.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';
import 'package:penhas/app/features/users/domain/entities/user_search_options.dart';
import 'package:penhas/app/features/users/domain/entities/user_search_session_entity.dart';

abstract class IUsersRepository {
  Future<Either<Failure, UserDetailEntity>> profileDetail(
    UserDetailProfileEntity profile,
  );
  Future<Either<Failure, UserSearchSessionEntity>> search(
    UserSearchOptions option,
  );
}

class UsersRepository implements IUsersRepository {
  final IApiProvider _apiProvider;

  UsersRepository({
    @required IApiProvider apiProvider,
  }) : this._apiProvider = apiProvider;

  @override
  Future<Either<Failure, UserDetailEntity>> profileDetail(
    UserDetailProfileEntity profile,
  ) async {
    final endPoint = "/profile";
    final parameters = {"cliente_id": profile.clientId?.toString()};

    try {
      final response = await _apiProvider
          .get(path: endPoint, parameters: parameters)
          .parseDetail();
      return right(response);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, UserSearchSessionEntity>> search(
      UserSearchOptions option) async {
    final endPoint = "/search-users";
    final parameters = {
      "name": option?.name,
      "skills": option?.skills?.join(","),
      "rows": option?.rows?.toString() ?? "100",
      "next_page": option.nextPage,
    };

    try {
      final response = await _apiProvider
          .get(path: endPoint, parameters: parameters)
          .parseSearchSession();
      return right(response);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }
}

extension _FutureExtension<T extends String> on Future<T> {
  Future<UserDetailEntity> parseDetail() async {
    return this.then((data) async {
      final jsonData = jsonDecode(data) as Map<String, Object>;
      return UserDetailModel.fromJson(jsonData);
    });
  }

  Future<UserSearchSessionEntity> parseSearchSession() async {
    return this
        .then((v) => jsonDecode(v) as Map<String, Object>)
        .then((v) => UserSearchSessionModel.fromJson(v));
  }
}
