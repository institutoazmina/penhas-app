import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/usecases/authentication_with_email_password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';

import '../../../../../utils/helper.mocks.dart';

void main() {
<<<<<<< HEAD
  late final MockIAppConfiguration mockAppConfiguration = MockIAppConfiguration();
  late final MockIAuthenticationRepository mockAuthenticatonRepository =
      MockIAuthenticationRepository();
=======
  late AuthenticationWithEmailAndPassword useCase;
  MockAppConfiguration? mockAppConfiguration;
  MockAuthenticatonRepository? mockAuthenticatonRepository;
>>>>>>> Migrate code to nullsafety

  late final AuthenticationWithEmailAndPassword useCase =
      AuthenticationWithEmailAndPassword(
    authenticationRepository: mockAuthenticatonRepository,
    appConfiguration: mockAppConfiguration,
  );

  group('authentication with email and password', () {
    const successSession = SessionEntity(
        sessionToken: 'my_strong_session_token',);
    final emailAddress = EmailAddress('valid@email.com');
    final password = SignInPassword('_myStr0ngP@ssw0rd', PasswordValidator());

    test('should get success response', () async {
      // arrange
      when(mockAuthenticatonRepository!.signInWithEmailAndPassword(
        emailAddress: anyNamed('emailAddress'),
        password: anyNamed('password'),
<<<<<<< HEAD
      ),).thenAnswer((_) async => right(successSession));
      when(mockAppConfiguration.saveApiToken(token: anyNamed('token')))
          .thenAnswer((_) async => Future.value());
      // act
      final Either<Failure, SessionEntity> result =
          await useCase(email: emailAddress, password: password);
      // assert
      expect(result, right(successSession));
      verify(mockAuthenticatonRepository.signInWithEmailAndPassword(
          emailAddress: emailAddress, password: password,),);
=======
      )).thenAnswer((_) async => right(successSession));
      when(mockAppConfiguration!.saveApiToken(token: anyNamed('token')))
          .thenAnswer((_) async => Future.value());
      // act
      final Either<Failure, SessionEntity>? result = await useCase(email: emailAddress, password: password);
      // assert
      expect(result, right(successSession));
      verify(mockAuthenticatonRepository!.signInWithEmailAndPassword(
          emailAddress: emailAddress, password: password));
>>>>>>> Migrate code to nullsafety
      verifyNoMoreInteractions(mockAuthenticatonRepository);
    });

    test(
        'should get UserAndPasswordInvalidFailure response for invalid user or password',
        () async {
      when(mockAuthenticatonRepository!.signInWithEmailAndPassword(
              emailAddress: anyNamed('emailAddress'),
              password: anyNamed('password'),),)
          .thenAnswer((_) async => left(UserAndPasswordInvalidFailure()));

<<<<<<< HEAD
      final Either<Failure, SessionEntity> result =
          await useCase(email: emailAddress, password: password);

      expect(result, left(UserAndPasswordInvalidFailure()));
      verify(mockAuthenticatonRepository.signInWithEmailAndPassword(
          emailAddress: emailAddress, password: password,),);
=======
      final Either<Failure, SessionEntity>? result = await useCase(email: emailAddress, password: password);

      expect(result, left(UserAndPasswordInvalidFailure()));
      verify(mockAuthenticatonRepository!.signInWithEmailAndPassword(
          emailAddress: emailAddress, password: password));
>>>>>>> Migrate code to nullsafety
      verifyNoMoreInteractions(mockAuthenticatonRepository);
    });
  });
}
