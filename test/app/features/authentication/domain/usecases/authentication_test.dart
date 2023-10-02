import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/authenticate_user.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';

class MockAppConfiguration extends Mock implements IAppConfiguration {}

class MockAuthenticationRepository extends Mock
    implements IAuthenticationRepository {}

void main() {
  late MockAppConfiguration mockAppConfiguration;
  late MockAuthenticationRepository mockAuthenticationRepository;
  late AuthenticateUserUseCase useCase;
  late SessionEntity successSession;
  late EmailAddress emailAddress;
  late SignInPassword password;

  setUp(() {
    mockAppConfiguration = MockAppConfiguration();
    mockAuthenticationRepository = MockAuthenticationRepository();
    useCase = AuthenticateUserUseCase(
      authenticationRepository: mockAuthenticationRepository
    );

    emailAddress = EmailAddress('valid@email.com');
    password = SignInPassword('_myStr0ngP@ssw0rd', PasswordValidator());
    successSession =
        const SessionEntity(sessionToken: 'my_strong_session_token');
  });

  group(AuthenticateUserUseCase, () {
    group('authentication with email and password', () {
      test('should get success response', () async {
        // arrange
        when(
          () => mockAuthenticationRepository.signInWithEmailAndPassword(
            emailAddress: emailAddress,
            password: password,
          ),
        ).thenAnswer((_) async => right(successSession));

        when(
          () => mockAppConfiguration.saveApiToken(
            token: successSession.sessionToken,
          ),
        ).thenAnswer((_) async => Future.value());
        // act
        final Either<Failure, SessionEntity> result =
            await useCase(email: emailAddress, password: password);
        // assert
        expect(result, right(successSession));
        verify(
          () => mockAuthenticationRepository.signInWithEmailAndPassword(
            emailAddress: emailAddress,
            password: password,
          ),
        ).called(1);

        verifyNoMoreInteractions(mockAuthenticationRepository);
      });

      test(
          'should get UserAndPasswordInvalidFailure response for invalid user or password',
          () async {
        when(
          () => mockAuthenticationRepository.signInWithEmailAndPassword(
            emailAddress: emailAddress,
            password: password,
          ),
        ).thenAnswer((_) async => left(UserAndPasswordInvalidFailure()));

        final Either<Failure, SessionEntity> result =
            await useCase(email: emailAddress, password: password);

        expect(result, left(UserAndPasswordInvalidFailure()));
        verify(
          () => mockAuthenticationRepository.signInWithEmailAndPassword(
            emailAddress: emailAddress,
            password: password,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockAuthenticationRepository);
      });
    });
  });
}
