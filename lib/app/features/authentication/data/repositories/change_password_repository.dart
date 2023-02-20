import 'package:dartz/dartz.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../shared/logger/log.dart';
import '../../domain/entities/reset_password_response_entity.dart';
import '../../domain/repositories/i_reset_password_repository.dart';
import '../../domain/usecases/email_address.dart';
import '../../domain/usecases/sign_up_password.dart';
import '../datasources/change_password_data_source.dart';

class ChangePasswordRepository
    implements IResetPasswordRepository, IChangePasswordRepository {
  ChangePasswordRepository({
    required IChangePasswordDataSource changePasswordDataSource,
    required INetworkInfo networkInfo,
  })  : _networkInfo = networkInfo,
        _dataSource = changePasswordDataSource;

  final IChangePasswordDataSource _dataSource;
  final INetworkInfo _networkInfo;

  @override
  Future<Either<Failure, ResetPasswordResponseEntity>> request({
    EmailAddress? emailAddress,
  }) async {
    try {
      final ResetPasswordResponseEntity result =
          await _dataSource.request(emailAddress: emailAddress);
      return right(result);
    } catch (e, stack) {
      logError(e, stack);
      final fail = await _handleError(e);
      return left(fail);
    }
  }

  @override
  Future<Either<Failure, ValidField>> reset({
    EmailAddress? emailAddress,
    SignUpPassword? password,
    String? resetToken,
  }) async {
    try {
      await _dataSource.reset(
        emailAddress: emailAddress,
        password: password,
        resetToken: resetToken,
      );
      return right(const ValidField());
    } catch (e, stack) {
      logError(e, stack);
      final fail = await _handleError(e);
      return left(fail);
    }
  }

  Future<Failure> _handleError(Object error) async {
    if (await _networkInfo.isConnected == false) {
      return InternetConnectionFailure();
    }

    if (error is ApiProviderException) {
      return ServerSideFormFieldValidationFailure(
        error: error.bodyContent['error'],
        field: error.bodyContent['field'],
        reason: error.bodyContent['reason'],
        message: error.bodyContent['message'],
      );
    }

    return ServerFailure();
  }

  @override
  Future<Either<Failure, ValidField>> validToken({
    EmailAddress? emailAddress,
    String? resetToken,
  }) async {
    try {
      await _dataSource.validToken(
        emailAddress: emailAddress,
        resetToken: resetToken,
      );
      return right(const ValidField());
    } catch (e, stack) {
      logError(e, stack);
      final fail = await _handleError(e);
      return left(fail);
    }
  }
}
