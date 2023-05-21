import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../shared/logger/log.dart';
import '../../../appstate/domain/entities/app_state_entity.dart';
import '../../domain/entities/quiz_request_entity.dart';
import '../../domain/repositories/i_quiz_repository.dart';
import '../datasources/quiz_data_source.dart';

class QuizRepository implements IQuizRepository {
  QuizRepository({
    required INetworkInfo networkInfo,
    required IQuizDataSource? dataSource,
  })  : _dataSource = dataSource,
        _networkInfo = networkInfo;

  final INetworkInfo _networkInfo;
  final IQuizDataSource? _dataSource;

  @override
  Future<Either<Failure, AppStateEntity>> update({
    required QuizRequestEntity? quiz,
  }) async {
    try {
      final appState = await _dataSource!.update(quiz: quiz);
      return right(appState);
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
