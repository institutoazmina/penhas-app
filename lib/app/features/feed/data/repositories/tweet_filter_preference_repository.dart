import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/error/api_provider_error_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../shared/logger/log.dart';
import '../../domain/entities/tweet_filter_session_entity.dart';
import '../models/tweet_filter_session_model.dart';

abstract class ITweetFilterPreferenceRepository {
  Future<Either<Failure, TweetFilterSessionEntity>> retrieve();
}

class TweetFilterPreferenceRepository
    implements ITweetFilterPreferenceRepository {
  TweetFilterPreferenceRepository({
    required IApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  final IApiProvider _apiProvider;

  @override
  Future<Either<Failure, TweetFilterSessionEntity>> retrieve() async {
    try {
      final result = await _apiProvider
          .get(path: '/filter-tags')
          .then((value) => jsonDecode(value))
          .then((value) => TweetFilterSessionModel.fromJson(value));

      return right(result);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }
}
