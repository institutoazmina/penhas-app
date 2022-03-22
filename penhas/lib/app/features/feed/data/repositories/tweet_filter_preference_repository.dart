import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_filter_preference_data_source.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';
import 'package:penhas/app/shared/logger/log.dart';

abstract class ITweetFilterPreferenceRepository {
  Future<Either<Failure, TweetFilterSessionEntity>> retreive();
}

class TweetFilterPreferenceRepository
    implements ITweetFilterPreferenceRepository {
  TweetFilterPreferenceRepository({
    required INetworkInfo networkInfo,
    required ITweetFilterPreferenceDataSource? dataSource,
  })  : _dataSource = dataSource,
        _networkInfo = networkInfo;

  final INetworkInfo _networkInfo;
  final ITweetFilterPreferenceDataSource? _dataSource;

  @override
  Future<Either<Failure, TweetFilterSessionEntity>> retreive() async {
    try {
      final result = await _dataSource!.fetch();
      return right(result);
    } catch (e, stack) {
      logError(e, stack);
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
          message: error.bodyContent['message'],);
    }

    if (error is ApiProviderSessionError) {
      return ServerSideSessionFailed();
    }

    return ServerFailure();
  }
}
