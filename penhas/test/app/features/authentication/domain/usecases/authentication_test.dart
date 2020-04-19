import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/authentication_with_email_password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

class MockAuthenticatonRepository extends Mock
    implements IAuthenticationRepository {}

void main() {
  AuthenticationWithEmailAndPassword useCase;
  MockAuthenticatonRepository mockAuthenticatonRepository;

  group('authentication with email and password', () {
    setUp(() {
      mockAuthenticatonRepository = MockAuthenticatonRepository();
      useCase = AuthenticationWithEmailAndPassword(mockAuthenticatonRepository);
    });

    final successSession = SessionEntity(
        fakePassword: false, sessionToken: 'my_strong_session_token');
    final emailAddress = EmailAddress("valid@email.com");
    final password = Password('_myStr0ngP@ssw0rd');

    test('should get success response', () async {
      when(mockAuthenticatonRepository.signInWithEmailAndPassword(
        emailAddress: anyNamed('emailAddress'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => right(successSession));

      final result = await useCase(email: emailAddress, password: password);

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
