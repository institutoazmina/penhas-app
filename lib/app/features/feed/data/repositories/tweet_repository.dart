import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/api_provider_error_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../shared/logger/log.dart';
import '../../domain/entities/tweet_engage_request_option.dart';
import '../../domain/entities/tweet_entity.dart';
import '../../domain/entities/tweet_request_option.dart';
import '../../domain/entities/tweet_session_entity.dart';
import '../../domain/repositories/i_tweet_repositories.dart';
import '../models/tweet_model.dart';
import '../models/tweet_session_model.dart';

class TweetRepository implements ITweetRepository {
  TweetRepository({
    required IApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  final IApiProvider _apiProvider;

  @override
  Future<Either<Failure, TweetEntity>> create({
    required TweetCreateRequestOption option,
  }) async {
    try {
      final bodyContent = Uri.encodeComponent(option.message);
      final result = await _apiProvider
          .post(path: '/me/tweets', body: 'content=$bodyContent')
          .then((value) => jsonDecode(value))
          .then((value) => TweetModel.fromJson(value));

      return right(result);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, TweetSessionEntity>> current({
    required TweetEngageRequestOption option,
  }) async {
    try {
      final Map<String, String> queryParameters = {'id': option.tweetId};
      final result = await _apiProvider
          .get(path: '/timeline', parameters: queryParameters)
          .then((value) => jsonDecode(value))
          .then((value) => TweetSessionModel.fromJson(value));

      return right(result);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, ValidField>> delete({
    required TweetEngageRequestOption option,
  }) async {
    try {
      final result = await _apiProvider
          .delete(path: '/me/tweets', parameters: {'id': option.tweetId})
          .then((value) => jsonDecode(value))
          .then((value) => ValidField.fromJson(value));
      return right(result);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, TweetSessionEntity>> fetch({
    required TweetRequestOption option,
  }) async {
    try {
      final Map<String, String?> queryParameters = {
        'after': option.after,
        'before': option.before,
        'parent_id': option.parent,
        'next_page': option.nextPageToken,
        'rows': '${option.rows}',
        'reply_to': option.replyTo,
        'category': option.category,
        'tags':
            (option.tags == null || option.tags!.isEmpty) ? null : option.tags,
      };

      final result = await _apiProvider
          .get(path: '/timeline', parameters: queryParameters)
          .then((value) => jsonDecode(value))
          .then((value) => TweetSessionModel.fromJson(value));

      return right(result);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, TweetEntity>> like({
    required TweetEngageRequestOption option,
  }) async {
    try {
      final result = await _apiProvider
          .post(
            path: '/timeline/${option.tweetId}/like',
            parameters: {'remove': option.dislike ? '1' : null},
          )
          .then((value) => jsonDecode(value))
          .then((value) => TweetModel.fromJson(value['tweet']));
      return right(result);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, TweetEntity>> reply({
    required TweetEngageRequestOption option,
  }) async {
    try {
      final bodyContent = Uri.encodeComponent(option.message);
      final result = await _apiProvider
          .post(
            path: '/timeline/${option.tweetId}/comment',
            body: 'content=$bodyContent',
          )
          .then((value) => jsonDecode(value))
          .then((value) => TweetModel.fromJson(value));

      return right(result);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, ValidField>> report({
    required TweetEngageRequestOption option,
  }) async {
    try {
      final bodyContent = Uri.encodeComponent(option.message);
      final result = await _apiProvider
          .post(
            path: '/timeline/${option.tweetId}/report',
            body: 'reason=$bodyContent',
          )
          .then((value) => jsonDecode(value))
          .then((value) => ValidField.fromJson(value));
      return right(result);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }
}
