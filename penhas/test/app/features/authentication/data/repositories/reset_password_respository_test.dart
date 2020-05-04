import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

import '../../../../../utils/json_util.dart';

abstract class IChangePasswordDataSource {
  Future<ValidField> reset({
    EmailAddress emailAddress,
    Password password,
    String resetToken,
  });
}

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
      {EmailAddress emailAddress}) {
    // TODO: implement request
    return null;
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
      return _handleError(e);
    }
  }

  Future<Either<Failure, ValidField>> _handleError(Object error) async {
    if (await _networkInfo.isConnected == false) {
      return left(InternetConnectionFailure());
    }

    if (error is ApiProviderException) {
      return left(ServerSideFormFieldValidationFailure(
        error: error.bodyContent['error'],
        field: error.bodyContent['field'],
        reason: error.bodyContent['reason'],
        message: error.bodyContent['message'],
      ));
    }

    return left(ServerFailure());
  }
}

class MockChangePasswordDataSource extends Mock
    implements IChangePasswordDataSource {}

class MockNetworkInfo extends Mock implements INetworkInfo {}

void main() {
  setUp(() {});

  group('ChangePasswordRepository', () {
    group('reset', () {
      test('should return ValidField for successfull password changed',
          () async {
        // arrange
        final IChangePasswordDataSource dataSource =
            MockChangePasswordDataSource();
        final INetworkInfo networkInfo = MockNetworkInfo();
        final sut = ChangePasswordRepository(
            changePasswordDataSource: dataSource, networkInfo: networkInfo);
        final EmailAddress emailAddress = EmailAddress('valid@email.com');
        final Password password = Password('my_new_str0ng_P4ssw0rd');
        final String resetToken = '666242';
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.reset(
                emailAddress: anyNamed('emailAddress'),
                password: anyNamed('password'),
                resetToken: anyNamed('resetToken')))
            .thenAnswer((_) async => ValidField());
        // act
        final result = await sut.reset(
          emailAddress: emailAddress,
          password: password,
          resetToken: resetToken,
        );
        // assert
        expect(result, right(ValidField()));
      });
      test(
          'should return ServerSideFormFieldValidationFailure for non successfull change password request',
          () async {
        // arrange
        final IChangePasswordDataSource dataSource =
            MockChangePasswordDataSource();
        final INetworkInfo networkInfo = MockNetworkInfo();
        final bodyContent = await JsonUtil.getJson(
            from: 'authentication/invalid_token_error.json');
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.reset(
                emailAddress: anyNamed('emailAddress'),
                password: anyNamed('password'),
                resetToken: anyNamed('resetToken')))
            .thenThrow(ApiProviderException(bodyContent: bodyContent));

        final sut = ChangePasswordRepository(
            changePasswordDataSource: dataSource, networkInfo: networkInfo);
        final EmailAddress emailAddress = EmailAddress('valid@email.com');
        final Password password = Password('my_new_str0ng_P4ssw0rd');
        final String resetToken = '666242';
        // act
        final result = await sut.reset(
          emailAddress: emailAddress,
          password: password,
          resetToken: resetToken,
        );
        // assert
        expect(result.isLeft(), true);

        expect(
          result,
          left(ServerSideFormFieldValidationFailure(
            error: bodyContent['error'],
            field: bodyContent['field'],
            message: bodyContent['message'],
            reason: bodyContent['reason'],
          )),
        );
      });
    });
  });
}
