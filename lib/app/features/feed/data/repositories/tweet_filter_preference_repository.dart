import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../shared/logger/log.dart';
import '../../domain/entities/tweet_filter_session_entity.dart';
import '../datasources/tweet_filter_preference_data_source.dart';

abstract class ITweetFilterPreferenceRepository {
  Future<Either<Failure, TweetFilterSessionEntity>> retrieve();
}

class TweetFilterPreferenceRepository
    implements ITweetFilterPreferenceRepository {
  TweetFilterPreferenceRepository({
    required INetworkInfo networkInfo,
    required ITweetFilterPreferenceDataSource dataSource,
  })  : _dataSource = dataSource,
        _networkInfo = networkInfo;

  final INetworkInfo _networkInfo;
  final ITweetFilterPreferenceDataSource _dataSource;

  @override
  Future<Either<Failure, TweetFilterSessionEntity>> retrieve() async {
    try {
      final result = await _dataSource.fetch();
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
        message: error.bodyContent['message'],
      );
    }

    if (error is ApiProviderSessionError) {
      return ServerSideSessionFailed();
    }

    return ServerFailure();
  }
}
