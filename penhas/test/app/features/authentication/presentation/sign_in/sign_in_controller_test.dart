import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_controller.dart';

class MockAuthenticatonRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  // initModule(SignInModule());
  MockAuthenticatonRepository mock;
  SignInController sut;

  //
  setUp(() {
    mock = MockAuthenticatonRepository();
    sut = SignInController(mock);

    // signin = SignInModule.to.get<SignInController>();
  });

  group('SignInController', () {
    test('should warning messages be empty on start', () {
      // assert
      expect(sut.warningPassword, "");
      expect(sut.warningEmail, "");
    });

    test("should show warning message for invalid email address", () {
      expect(sut.warningEmail, "");
      // arrange
      var invalidEmailAddress = 'myaddress';
      // act
      sut.setEmail(invalidEmailAddress);
      // assert
      expect(sut.warningEmail, WARNING_INVALID_EMAIL);
    });

    test("should reset warning message after user input valid email address",
        () {
      // arrange
      var invalidEmailAddress = 'myaddress';
      var validEmailAddress = 'my_email@app.com';
      // act
      sut.setEmail(invalidEmailAddress);
      sut.setEmail(validEmailAddress);
      // assert
      expect(sut.warningEmail, '');
    });

    test('should show warning message for a invalid password', () {
      // arrange
      var invalidPassword = '1';
      // act
      sut.setPassword(invalidPassword);
      // assert
      expect(sut.warningPassword, WARNING_INVALID_PASSWORD);
    });

    test('should reset warning message after user input a valid password', () {
      // arrange
      var invalidPassword = '';
      var validPassword = 'sTr0ng';
      // act
      sut.setPassword(invalidPassword);
      sut.setPassword(validPassword);
      // assert
      expect(sut.warningPassword, '');
    });

    void mockAuthenticationFailure(Failure failure) {
      when(mock.signInWithEmailAndPassword(
        emailAddress: anyNamed('emailAddress'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => left(failure));
    }

    test("should validate inputs before hits repository", () async {
      // arrange
      mockAuthenticationFailure(ServerFailure());
      // act
      await sut.signInWithEmailAndPasswordPressed();
      // assert
      verifyZeroInteractions(mock);
    });

    void testServerError(Failure failure, String errorMessage) async {
      // arrange
      mockAuthenticationFailure(failure);
      var validPassword = 'sTr0ng';
      var validEmailAddress = 'my_email@app.com';
      // act
      sut.setPassword(validPassword);
      sut.setEmail(validEmailAddress);
      await sut.signInWithEmailAndPasswordPressed();
      // assert
      expect(sut.errorAuthenticationMessage, errorMessage);
    }

    test("should show SERVER_FAILURE message when got ServerFailure", () async {
      testServerError(ServerFailure(), ERROR_SERVER_FAILURE);
    });

    test(
        "should show ERROR_INTERNET_CONNECTION_FAILURE message when got ServerFailure",
        () async {
      testServerError(
          InternetConnectionFailure(), ERROR_INTERNET_CONNECTION_FAILURE);
    });

    test(
        'should show ERROR_USER_AUTHENTICATION_FAILURE message when got UserAuthenticationFailure',
        () async {
      // arrange
      mockAuthenticationFailure(UserAuthenticationFailure());
      var validPassword = 'sTr0ng';
      var validEmailAddress = 'my_email@app.com';
      // act
      sut.setPassword(validPassword);
      sut.setEmail(validEmailAddress);
      await sut.signInWithEmailAndPasswordPressed();
      // assert
      expect(sut.errorAuthenticationMessage, ERROR_USER_AUTHENTICATION_FAILURE);
    });
  });
}
