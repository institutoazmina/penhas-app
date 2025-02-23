import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/request_reset_password.dart';

void main() {
  late EmailAddress emailAddress;
  late MockResetPasswordRepository repository;
  late RequestResetPassword sut;

  const responseTtl = 3600;
  const responseDigits = 6;
  const responseMessage = 'Enviamos um código com 6 números para o seu e-mail';
  const responseTtlRetry = 216;

  setUp(() {
    emailAddress = EmailAddress('valid_email@exemple.com');
    repository = MockResetPasswordRepository();
    sut = RequestResetPassword(resetPasswordRepository: repository);
  });

  group(RequestResetPassword, () {
    test(
      'received a ResetPasswordResponseEntity for successful request',
      () async {
        // arrange
        when(() => repository.request(emailAddress: emailAddress)).thenAnswer(
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
      },
    );
  });
}

class MockResetPasswordRepository extends Mock
    implements IResetPasswordRepository {}
