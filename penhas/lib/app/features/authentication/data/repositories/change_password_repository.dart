import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/authentication/data/datasources/change_password_data_source.dart';
import 'package:penhas/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

class ChangePasswordRepository
    implements IResetPasswordRepository, IChangePasswordRepository {
  final IChangePasswordDataSource _dataSource;
  final INetworkInfo _networkInfo;

  factory ChangePasswordRepository({
    @required IChangePasswordDataSource changePasswordDataSource,
    @required INetworkInfo networkInfo,
  }) {
    return ChangePasswordRepository._(changePasswordDataSource, networkInfo);
  }

  ChangePasswordRepository._(this._dataSource, this._networkInfo);

  @override
  Future<Either<Failure, ResetPasswordResponseEntity>> request(
      {EmailAddress emailAddress}) async {
    try {
      final ResetPasswordResponseEntity result =
          await _dataSource.request(emailAddress: emailAddress);
      return right(result);
    } catch (e) {
      final fail = await _handleError(e);
      return left(fail);
    }
  }

  @override
  Future<Either<Failure, ValidField>> reset({
    EmailAddress emailAddress,
    Password password,
    String resetToken,
  }) async {
    try {
      await _dataSource.reset(
        emailAddress: emailAddress,
        password: password,
        resetToken: resetToken,
      );
      return right(ValidField());
    } catch (e) {
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
  Future<Either<Failure, ValidField>> validToken(
      {EmailAddress emailAddress, String resetToken}) async {
    try {
      await _dataSource.validToken(
        emailAddress: emailAddress,
        resetToken: resetToken,
      );
      return right(ValidField());
    } catch (e) {
      final fail = await _handleError(e);
      return left(fail);
    }
  }
}
