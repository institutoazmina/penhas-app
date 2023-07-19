import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/authentication/data/datasources/change_password_data_source.dart';
import 'package:penhas/app/features/authentication/data/models/password_reset_response_model.dart';
import 'package:penhas/app/features/authentication/data/repositories/change_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

import '../../../../../utils/json_util.dart';

class MockChangePasswordDataSource extends Mock
    implements IChangePasswordDataSource {}

class MockNetworkInfo extends Mock implements INetworkInfo {}

void main() {
  late EmailAddress emailAddress;
  late SignUpPassword password;
  late String resetToken;

  late INetworkInfo networkInfo;
  late ChangePasswordRepository sut;
  late IChangePasswordDataSource dataSource;

  setUp(() {
    emailAddress = EmailAddress('valid@email.com');
    password = SignUpPassword('my_new_str0ng_P4ssw0rd', PasswordValidator());
    resetToken = '666242';

    networkInfo = MockNetworkInfo();
    dataSource = MockChangePasswordDataSource();

    sut = ChangePasswordRepository(
      changePasswordDataSource: dataSource,
      networkInfo: networkInfo,
    );

    when(() => networkInfo.isConnected).thenAnswer((_) async => true);
  });

  group(ChangePasswordRepository, () {
    group(
      'reset()',
      () {
        test(
          'return ValidField for successful password changed',
          () async {
            // arrange
            when(
              () => dataSource.reset(
                emailAddress: emailAddress,
                password: password,
                resetToken: resetToken,
              ),
            ).thenAnswer((_) async => const ValidField());
            // act
            final result = await sut.reset(
              emailAddress: emailAddress,
              password: password,
              resetToken: resetToken,
            );
            // assert
            expect(result, right(const ValidField()));
          },
        );
        test(
            'return ServerSideFormFieldValidationFailure for non successful change password request',
            () async {
          // arrange
          final bodyContent = await JsonUtil.getJson(
            from: 'authentication/invalid_token_error.json',
          );
          when(
            () => dataSource.reset(
              emailAddress: emailAddress,
              password: password,
              resetToken: resetToken,
            ),
          ).thenThrow(ApiProviderException(bodyContent: bodyContent));
          // act
          final result = await sut.reset(
            emailAddress: emailAddress,
            password: password,
            resetToken: resetToken,
          );
          // assert
          expect(
            result,
            left(
              ServerSideFormFieldValidationFailure(
                error: bodyContent['error'] as String?,
                field: bodyContent['field'] as String?,
                message: bodyContent['message'] as String?,
                reason: bodyContent['reason'] as String?,
              ),
            ),
          );
        });
      },
    );
    group('request()', () {
      test('return ResetPasswordResponseEntity for a successful request',
          () async {
        // arrange
        final bodyContent = await JsonUtil.getJson(
          from: 'authentication/request_reset_password.json',
        );
        final modelResponse = PasswordResetResponseModel.fromJson(bodyContent);
        when(() => dataSource.request(emailAddress: emailAddress))
            .thenAnswer((_) async => modelResponse);
        // act
        final result = await sut.request(emailAddress: emailAddress);
        // assert
        expect(
          result,
          right(
            PasswordResetResponseModel(
              message: bodyContent['message'] as String?,
              digits: bodyContent['digits'] as int?,
              ttl: bodyContent['ttl'] as int?,
              ttlRetry: bodyContent['min_ttl_retry'] as int?,
            ),
          ),
        );
      });
      test(
          'return ServerSideFormFieldValidationFailure for non successful change password request',
          () async {
        // arrange
        final bodyContent =
            await JsonUtil.getJson(from: 'authentication/email_not_found.json');
        when(() => dataSource.request(emailAddress: emailAddress))
            .thenThrow(ApiProviderException(bodyContent: bodyContent));
        // act
        final result = await sut.request(
          emailAddress: emailAddress,
        );
        // assert
        expect(
          result,
          left(
            ServerSideFormFieldValidationFailure(
              error: bodyContent['error'] as String?,
              field: bodyContent['field'] as String?,
              message: bodyContent['message'] as String?,
              reason: bodyContent['reason'] as String?,
            ),
          ),
        );
      });
    });

    group(
      'validToken()',
      () {
        test(
          'return ValidField for successful token validation',
          () async {
            // arrange
            when(
              () => dataSource.validToken(
                emailAddress: emailAddress,
                resetToken: resetToken,
              ),
            ).thenAnswer((_) async => const ValidField());
            // act
            final result = await sut.validToken(
              emailAddress: emailAddress,
              resetToken: resetToken,
            );
            // assert
            expect(result, right(const ValidField()));
          },
        );
        test(
            'return ServerSideFormFieldValidationFailure for non successful token validation',
            () async {
          // arrange
          final bodyContent = await JsonUtil.getJson(
            from: 'authentication/invalid_token_error.json',
          );
          when(
            () => dataSource.validToken(
              emailAddress: emailAddress,
              resetToken: resetToken,
            ),
          ).thenThrow(ApiProviderException(bodyContent: bodyContent));
          // act
          final result = await sut.validToken(
            emailAddress: emailAddress,
            resetToken: resetToken,
          );
          // assert
          expect(
            result,
            left(
              ServerSideFormFieldValidationFailure(
                error: bodyContent['error'] as String?,
                field: bodyContent['field'] as String?,
                message: bodyContent['message'] as String?,
                reason: bodyContent['reason'] as String?,
              ),
            ),
          );
        });
      },
    );
  });
}
