import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';

class TweetRepository implements ITweetRepository {
  final INetworkInfo _networkInfo;
  final ITweetDataSource _dataSource;

  TweetRepository({
    @required INetworkInfo networkInfo,
    @required ITweetDataSource dataSource,
  })  : this._dataSource = dataSource,
        this._networkInfo = networkInfo;

  @override
  Future<Either<Failure, TweetSessionEntity>> fetch({
    @required TweetRequestOption option,
  }) async {
    try {
      final result = await _dataSource.fetch(option: option);
      return right(result);
    } catch (e) {
      return left(await _handleError(e));
    }
  }

  @override
  Future<Either<Failure, TweetSessionEntity>> current({
    TweetEngageRequestOption option,
  }) async {
    try {
      final result = await _dataSource.current(option: option);
      return right(result);
    } catch (e) {
      return left(await _handleError(e));
    }
  }

  @override
  Future<Either<Failure, TweetEntity>> create(
      {TweetCreateRequestOption option}) async {
    try {
      final result = await _dataSource.create(option: option);
      return right(result);
    } catch (e) {
      return left(await _handleError(e));
    }
  }

  @override
  Future<Either<Failure, TweetEntity>> reply(
      {TweetEngageRequestOption option}) async {
    try {
      final result = await _dataSource.reply(option: option);
      return right(result);
    } catch (e) {
      return left(await _handleError(e));
    }
  }

  @override
  Future<Either<Failure, TweetEntity>> like(
      {TweetEngageRequestOption option}) async {
    try {
      final result = await _dataSource.like(option: option);
      return right(result);
    } catch (e) {
      return left(await _handleError(e));
    }
  }

  @override
  Future<Either<Failure, ValidField>> delete(
      {TweetEngageRequestOption option}) async {
    try {
      final result = await _dataSource.delete(option: option);
      return right(result);
    } catch (e) {
      return left(await _handleError(e));
    }
  }

  @override
  Future<Either<Failure, ValidField>> report(
      {TweetEngageRequestOption option}) async {
    try {
      final result = await _dataSource.report(option: option);
      return right(result);
    } catch (e) {
      return left(await _handleError(e));
    }
  }

  Future<Failure> _handleError(Object error) async {
    if (await _networkInfo.isConnected == false) {
      return InternetConnectionFailure();
    }

    if (error is ApiProviderException) {
      if (error.bodyContent['error'] == 'expired_jwt') {
        return ServerSideSessionFailed();
      }

      return ServerSideFormFieldValidationFailure(
          error: error.bodyContent['error'],
          field: error.bodyContent['field'],
          reason: error.bodyContent['reason'],
          message: error.bodyContent['message']);
    }

    if (error is ApiProviderSessionExpection) {
      return ServerSideSessionFailed();
    }

    return ServerFailure();
  }
}
