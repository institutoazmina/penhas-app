import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/authenticate_user.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/login_offline_toggle.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';

void main() {
  group(AuthenticateUserUseCase, () {
    late IAppConfiguration mockAppConfiguration;
    late IAuthenticationRepository mockAuthenticationRepository;
    late AuthenticateUserUseCase useCase;
    late SessionEntity successSession;
    late EmailAddress emailAddress;
    late SignInPassword password;

    setUp(() {
      mockAppConfiguration = _MockAppConfiguration();
      mockAuthenticationRepository = _MockAuthenticationRepository();
      useCase = AuthenticateUserUseCase(
        authenticationRepository: mockAuthenticationRepository,
      );

      emailAddress = EmailAddress('valid@email.com');
      password = SignInPassword('_myStr0ngP@ssw0rd', PasswordValidator());
      successSession =
          const SessionEntity(sessionToken: 'my_strong_session_token');
    });

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

  group(AuthenticateStealthUserUseCase, () {
    late AuthenticateStealthUserUseCase sut;

    late IAuthenticationRepository mockAuthenticationRepository;
    late LoginOfflineToggleFeature mockLoginOfflineToggleFeature;

    setUpAll(() {
      registerFallbackValue(_FakeEmailAddress());
      registerFallbackValue(_FakeSignInPassword());
    });

    setUp(() {
      mockAuthenticationRepository = _MockAuthenticationRepository();
      mockLoginOfflineToggleFeature = _MockLoginOfflineToggleFeature();
      sut = AuthenticateStealthUserUseCase(
        authenticationRepository: mockAuthenticationRepository,
        loginOfflineToggleFeature: mockLoginOfflineToggleFeature,
      );
    });

    test(
      'should call signInWithEmailAndPassword when offline is disabled',
      () async {
        // arrange
        final email = EmailAddress('example@email.com');
        final password = SignInPassword('P@ssw0rd', PasswordValidator());
        when(() => mockLoginOfflineToggleFeature.isEnabled).thenReturn(false);
        when(
          () => mockAuthenticationRepository.signInWithEmailAndPassword(
            emailAddress: any(named: 'emailAddress'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => right(_FakeSessionEntity()));

        // act
        await sut(email: email, password: password);

        // assert
        verify(
          () => mockAuthenticationRepository.signInWithEmailAndPassword(
            emailAddress: email,
            password: password,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockAuthenticationRepository);
      },
    );

    test(
      'should call signInOffline when offline is enabled',
      () async {
        // arrange
        final email = EmailAddress('example@email.com');
        final password = SignInPassword('P@ssw0rd', PasswordValidator());
        when(() => mockLoginOfflineToggleFeature.isEnabled).thenReturn(true);
        when(
          () => mockAuthenticationRepository.signInOffline(
            emailAddress: any(named: 'emailAddress'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => right(_FakeSessionEntity()));

        // act
        await sut(email: email, password: password);

        // assert
        verify(
          () => mockAuthenticationRepository.signInOffline(
            emailAddress: email,
            password: password,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockAuthenticationRepository);
      },
    );
  });

  group(AuthenticateAnonymousUserUseCase, () {
    late AuthenticateAnonymousUserUseCase sut;

    late IAuthenticationRepository mockAuthenticationRepository;
    late LoginOfflineToggleFeature mockLoginOfflineToggleFeature;

    setUpAll(() {
      registerFallbackValue(_FakeEmailAddress());
      registerFallbackValue(_FakeSignInPassword());
    });

    setUp(() {
      mockAuthenticationRepository = _MockAuthenticationRepository();
      mockLoginOfflineToggleFeature = _MockLoginOfflineToggleFeature();
      sut = AuthenticateAnonymousUserUseCase(
        authenticationRepository: mockAuthenticationRepository,
        loginOfflineToggleFeature: mockLoginOfflineToggleFeature,
      );
    });

    test(
      'should call signInWithEmailAndPassword when offline is disabled',
      () async {
        // arrange
        final email = EmailAddress('example@email.com');
        final password = SignInPassword('P@ssw0rd', PasswordValidator());
        when(() => mockLoginOfflineToggleFeature.isEnabled).thenReturn(false);
        when(
          () => mockAuthenticationRepository.signInWithEmailAndPassword(
            emailAddress: any(named: 'emailAddress'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => right(_FakeSessionEntity()));

        // act
        await sut(email: email, password: password);

        // assert
        verify(
          () => mockAuthenticationRepository.signInWithEmailAndPassword(
            emailAddress: email,
            password: password,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockAuthenticationRepository);
      },
    );

    test(
      'should call signInOffline when offline is enabled',
      () async {
        // arrange
        final email = EmailAddress('example@email.com');
        final password = SignInPassword('P@ssw0rd', PasswordValidator());
        when(() => mockLoginOfflineToggleFeature.isEnabled).thenReturn(true);
        when(
          () => mockAuthenticationRepository.signInOffline(
            emailAddress: any(named: 'emailAddress'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => right(_FakeSessionEntity()));

        // act
        await sut(email: email, password: password);

        // assert
        verify(
          () => mockAuthenticationRepository.signInOffline(
            emailAddress: email,
            password: password,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockAuthenticationRepository);
      },
    );
  });
}

class _MockAppConfiguration extends Mock implements IAppConfiguration {}

class _MockAuthenticationRepository extends Mock
    implements IAuthenticationRepository {}

class _MockLoginOfflineToggleFeature extends Mock
    implements LoginOfflineToggleFeature {}

class _FakeSessionEntity extends Fake implements SessionEntity {}

class _FakeEmailAddress extends Fake implements EmailAddress {}

class _FakeSignInPassword extends Fake implements SignInPassword {}
