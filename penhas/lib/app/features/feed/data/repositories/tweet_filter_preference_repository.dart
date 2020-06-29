import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_filter_preference_data_source.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';

abstract class ITweetFilterPreferenceRepository {
  Future<Either<Failure, TweetFilterSessionEntity>> retreive();
}

class TweetFilterPreferenceRepository
    implements ITweetFilterPreferenceRepository {
  final INetworkInfo _networkInfo;
  final ITweetFilterPreferenceDataSource _dataSource;

  TweetFilterPreferenceRepository({
    @required INetworkInfo networkInfo,
    @required ITweetFilterPreferenceDataSource dataSource,
  })  : this._dataSource = dataSource,
        this._networkInfo = networkInfo;

  @override
  Future<Either<Failure, TweetFilterSessionEntity>> retreive() async {
    try {
      final result = await _dataSource.fetch();
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
