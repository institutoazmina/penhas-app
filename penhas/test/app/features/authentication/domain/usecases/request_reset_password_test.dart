import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/request_reset_password.dart';

import '../../../../../utils/helper.mocks.dart';

void main() {
<<<<<<< HEAD
  late final EmailAddress emailAddress =
      EmailAddress('valid_email@exemple.com');
  late final MockIResetPasswordRepository repository =
      MockIResetPasswordRepository();
  late final RequestResetPassword sut =
      RequestResetPassword(resetPasswordRepository: repository);
=======
  EmailAddress? emailAddress;
  IResetPasswordRepository? repository;
  late RequestResetPassword sut;
>>>>>>> Migrate code to nullsafety

  const responseTtl = 3600;
  const responseDigits = 6;
  const responseMessage = 'Enviamos um código com 6 números para o seu e-mail';
  const responseTtlRetry = 216;

  group('Request reset password', () {
    test('should received a ResetPasswordResponseEntity for successful request',
        () async {
      // arrange
<<<<<<< HEAD
      when(repository.request(emailAddress: anyNamed('emailAddress')))
          .thenAnswer(
        (_) async => right(
          const ResetPasswordResponseEntity(
            message: responseMessage,
            digits: responseDigits,
            ttl: responseTtl,
            ttlRetry: responseTtlRetry,
          ),
        ),
      );
      // act
      final Either<Failure, ResetPasswordResponseEntity> result =
          await sut(email: emailAddress);
=======
      when(repository!.request(emailAddress: anyNamed('emailAddress')))
          .thenAnswer((_) async => right(ResetPasswordResponseEntity(
                message: RESPONSE_MESSAGE,
                digits: RESPONSE_DIGITS,
                ttl: RESPONSE_TTL,
                ttlRetry: RESPONSE_TTL_RETRY,
              )));
      // act
      final Either<Failure, ResetPasswordResponseEntity>? result = await sut(email: emailAddress!);
>>>>>>> Migrate code to nullsafety
      // assert
      expect(
        result,
        right(
          const ResetPasswordResponseEntity(
            message: responseMessage,
            digits: responseDigits,
            ttl: responseTtl,
            ttlRetry: responseTtlRetry,
          ),
        ),
      );
    });
  });
}
