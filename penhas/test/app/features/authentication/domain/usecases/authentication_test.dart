import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/authentication_with_email_password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

class MockAuthenticatonRepository extends Mock
    implements IAuthenticationRepository {}

class MockAppConfiguration extends Mock implements IAppConfiguration {}

void main() {
  AuthenticationWithEmailAndPassword useCase;
  MockAppConfiguration mockAppConfiguration;
  MockAuthenticatonRepository mockAuthenticatonRepository;

  group('authentication with email and password', () {
    setUp(() {
      mockAppConfiguration = MockAppConfiguration();
      mockAuthenticatonRepository = MockAuthenticatonRepository();
      useCase = AuthenticationWithEmailAndPassword(
        authenticationRepository: mockAuthenticatonRepository,
        appConfiguration: mockAppConfiguration,
      );
    });

    final successSession =
        SessionEntity(sessionToken: 'my_strong_session_token');
    final emailAddress = EmailAddress("valid@email.com");
    final password = Password('_myStr0ngP@ssw0rd');

    test('should get success response', () async {
      // arrange
      when(mockAuthenticatonRepository.signInWithEmailAndPassword(
        emailAddress: anyNamed('emailAddress'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => right(successSession));
      when(mockAppConfiguration.saveApiToken(token: anyNamed('token')))
          .thenAnswer((_) async => Future.value());
      // act
      final result = await useCase(email: emailAddress, password: password);
      // assert
      expect(result, right(successSession));
      verify(mockAuthenticatonRepository.signInWithEmailAndPassword(
          emailAddress: emailAddress, password: password));
      verifyNoMoreInteractions(mockAuthenticatonRepository);
    });

    test(
        'should get UserAndPasswordInvalidFailure response for invalid user or password',
        () async {
      when(mockAuthenticatonRepository.signInWithEmailAndPassword(
              emailAddress: anyNamed('emailAddress'),
              password: anyNamed('password')))
          .thenAnswer((_) async => left(UserAndPasswordInvalidFailure()));

      final result = await useCase(email: emailAddress, password: password);

      expect(result, left(UserAndPasswordInvalidFailure()));
      verify(mockAuthenticatonRepository.signInWithEmailAndPassword(
          emailAddress: emailAddress, password: password));
      verifyNoMoreInteractions(mockAuthenticatonRepository);
    });
  });
}
