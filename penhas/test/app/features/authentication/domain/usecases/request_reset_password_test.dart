import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/request_reset_password.dart';

class MockResetPasswordRepository extends Mock
    implements IResetPasswordRepository {}

void main() {
  EmailAddress emailAddress;
  IResetPasswordRepository repository;
  RequestResetPassword sut;

  const RESPONSE_TTL = 3600;
  const RESPONSE_DIGITS = 6;
  const RESPONSE_MESSAGE = 'Enviamos um código com 6 números para o seu e-mail';
  const RESPONSE_TTL_RETRY = 216;

  setUp(() {
    emailAddress = EmailAddress('valid_email@exemple.com');
    repository = MockResetPasswordRepository();
    sut = RequestResetPassword(resetPasswordRepository: repository);
  });

  group('Request reset password', () {
    test(
        'should received a ResetPasswordResponseEntity for successfull request',
        () async {
      // arrange
      when(repository.request(emailAddress: anyNamed('emailAddress')))
          .thenAnswer((_) async => right(ResetPasswordResponseEntity(
                message: RESPONSE_MESSAGE,
                digits: RESPONSE_DIGITS,
                ttl: RESPONSE_TTL,
                ttlRetry: RESPONSE_TTL_RETRY,
              )));
      // act
      final result = await sut(email: emailAddress);
      // assert
      expect(
          result,
          right(ResetPasswordResponseEntity(
            message: RESPONSE_MESSAGE,
            digits: RESPONSE_DIGITS,
            ttl: RESPONSE_TTL,
            ttlRetry: RESPONSE_TTL_RETRY,
          )));
    });
  });
}
