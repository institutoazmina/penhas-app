import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_controller.dart';

import '../../../../../utils/helper.mocks.dart';

void main() {
  late final MockAuthenticationRepository authenticationRepositoryMock =
      MockAuthenticationRepository();
  late final MockAppStateUseCase appStateUseCaseMock = MockAppStateUseCase();
  late SignInController sut;

  //
  setUp(() {
    sut = SignInController(
      authenticationRepositoryMock,
      PasswordValidator(),
      appStateUseCaseMock,
    );
  });

  group('SignInController', () {
    const warningEmail = 'Endereço de email inválido';
    const String internetConnectionFailure =
        'O servidor está inacessível, o PenhaS está com acesso à Internet?';
    const String serverFailure =
        'O servidor está com problema neste momento, tente novamente.';

    test('should warning messages be empty on start', () {
      // assert
      expect(sut.warningPassword, '');
      expect(sut.warningEmail, '');
    });

    test('should show warning message for invalid email address', () {
      expect(sut.warningEmail, '');
      // arrange
      const invalidEmailAddress = 'myaddress';
      // act
      sut.setEmail(invalidEmailAddress);
      // assert
      expect(sut.warningEmail, warningEmail);
    });

    test('should reset warning message after user input valid email address',
        () {
      // arrange
      const invalidEmailAddress = 'myaddress';
      const validEmailAddress = 'my_email@app.com';
      // act
      sut.setEmail(invalidEmailAddress);
      sut.setEmail(validEmailAddress);
      // assert
      expect(sut.warningEmail, '');
    });

    test('should reset warning message after user input a valid password', () {
      // arrange
      const invalidPassword = '';
      const validPassword = 'sTr0ngMy';
      // act
      sut.setPassword(invalidPassword);
      sut.setPassword(validPassword);
      // assert
      expect(sut.warningPassword, '');
    });

    void mockAuthenticationFailure(Failure failure) {
      when(
        authenticationRepositoryMock.signInWithEmailAndPassword(
          emailAddress: anyNamed('emailAddress'),
          password: anyNamed('password'),
        ),
      ).thenAnswer((_) async => left(failure));
    }

    test('should validate inputs before hits repository', () async {
      // arrange
      mockAuthenticationFailure(ServerFailure());
      // act
      await sut.signInWithEmailAndPasswordPressed();
      // assert
      verifyZeroInteractions(authenticationRepositoryMock);
    });

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

    test('should show SERVER_FAILURE message when got ServerFailure', () async {
      testServerError(ServerFailure(), serverFailure);
    });

    test(
        'should show ERROR_INTERNET_CONNECTION_FAILURE message when got ServerFailure',
        () async {
      testServerError(InternetConnectionFailure(), internetConnectionFailure);
    });
  });
}
