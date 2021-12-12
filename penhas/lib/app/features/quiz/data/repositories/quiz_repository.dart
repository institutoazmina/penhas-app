import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/quiz/data/datasources/quiz_data_source.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_request_entity.dart';
import 'package:penhas/app/features/quiz/domain/repositories/i_quiz_repository.dart';
import 'package:penhas/app/shared/logger/log.dart';

class QuizRepository implements IQuizRepository {
  final INetworkInfo _networkInfo;
  final IQuizDataSource? _dataSource;

  QuizRepository({
    required INetworkInfo networkInfo,
    required IQuizDataSource? dataSource,
  })  : this._dataSource = dataSource,
        this._networkInfo = networkInfo;

  @override
  Future<Either<Failure, AppStateEntity>> update(
      {required QuizRequestEntity? quiz}) async {
    try {
      final appState = await _dataSource!.update(quiz: quiz);
      return right(appState);
    } catch (e) {
      logError(e);
      return left(await _handleError(e));
    }
  }

  Future<Failure> _handleError(Object error) async {
    if (await _networkInfo.isConnected == false) {
      return InternetConnectionFailure();
    }

    if (error is ApiProviderException) {
      if (error.bodyContent!['error'] == 'expired_jwt') {
        return ServerSideSessionFailed();
      }

      return ServerSideFormFieldValidationFailure(
          error: error.bodyContent!['error'],
          field: error.bodyContent!['field'],
          reason: error.bodyContent!['reason'],
          message: error.bodyContent!['message']);
    }

    if (error is ApiProviderSessionError) {
      return ServerSideSessionFailed();
    }

    return ServerFailure();
  }
}
