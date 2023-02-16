import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_controller.dart';

void main() {
  late SignInController sut;
  late AppStateUseCase appStateUseCaseMock;
  late IAuthenticationRepository authenticationRepositoryMock;

  setUp(() {
    appStateUseCaseMock = MockAppStateUseCase();
    authenticationRepositoryMock = MockAuthenticationRepository();

    sut = SignInController(
      authenticationRepositoryMock,
      PasswordValidator(),
      appStateUseCaseMock,
    );
  });

  setUpAll(() {
    registerFallbackValue(EmailAddress(null));
    registerFallbackValue(SignInPassword('', PasswordValidator()));
  });

  group(SignInController, () {
    const warningEmail = 'Endereço de email inválido';
    const String internetConnectionFailure =
        'O servidor está inacessível, o PenhaS está com acesso à Internet?';
    const String serverFailure =
        'O servidor está com problema neste momento, tente novamente.';

    test(
      'warning messages be empty on start',
      () {
        // assert
        expect(sut.warningPassword, '');
        expect(sut.warningEmail, '');
      },
    );

    test(
      'show warning message for invalid email address',
      () {
        expect(sut.warningEmail, '');
        // arrange
        const invalidEmailAddress = 'myaddress';
        // act
        sut.setEmail(invalidEmailAddress);
        // assert
        expect(sut.warningEmail, warningEmail);
      },
    );

    test(
      'reset warning message after user input valid email address',
      () {
        // arrange
        const invalidEmailAddress = 'myaddress';
        const validEmailAddress = 'my_email@app.com';
        // act
        sut.setEmail(invalidEmailAddress);
        sut.setEmail(validEmailAddress);
        // assert
        expect(sut.warningEmail, '');
      },
    );

    test(
      'reset warning message after user input a valid password',
      () {
        // arrange
        const invalidPassword = '';
        const validPassword = 'sTr0ngMy';
        // act
        sut.setPassword(invalidPassword);
        sut.setPassword(validPassword);
        // assert
        expect(sut.warningPassword, '');
      },
    );

    void mockAuthenticationFailure(Failure failure) {
      when(
        () => authenticationRepositoryMock.signInWithEmailAndPassword(
          emailAddress: any(named: 'emailAddress'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => left(failure));
    }

    test(
      'validate inputs before hits repository',
      () async {
        // arrange
        mockAuthenticationFailure(ServerFailure());
        // act
        await sut.signInWithEmailAndPasswordPressed();
        // assert
        verifyZeroInteractions(authenticationRepositoryMock);
      },
    );

    Future<void> testServerError(Failure failure, String errorMessage) async {
      // arrange
      mockAuthenticationFailure(failure);
      const validPassword = 'sTr0ngMy';
      const validEmailAddress = 'my_email@app.com';
      // act
      sut.setPassword(validPassword);
      sut.setEmail(validEmailAddress);
      await sut.signInWithEmailAndPasswordPressed();
      // assert
      expect(sut.errorMessage, errorMessage);
    }

    test(
      'show SERVER_FAILURE message when got ServerFailure',
      () async {
        testServerError(ServerFailure(), serverFailure);
      },
    );

    test(
      'show ERROR_INTERNET_CONNECTION_FAILURE message when got ServerFailure',
      () async {
        testServerError(InternetConnectionFailure(), internetConnectionFailure);
      },
    );
  });
}

class MockAuthenticationRepository extends Mock
    implements IAuthenticationRepository {}

class MockAppStateUseCase extends Mock implements AppStateUseCase {}
