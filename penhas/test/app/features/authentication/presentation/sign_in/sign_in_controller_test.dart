import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
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
      expect(sut.invalidPassword, "");
      expect(sut.invalidEmailAddress, "");
    });

    test("should show warning message for invalid email address", () {
      expect(sut.invalidEmailAddress, "");
      // arrange
      var invalidEmailAddress = 'myaddress';
      // act
      sut.setEmail(invalidEmailAddress);
      // assert
      expect(sut.invalidEmailAddress, WARNING_INVALID_EMAIL);
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
      expect(sut.invalidEmailAddress, '');
    });

    test('should show warning message for a invalid password', () {
      // arrange
      var invalidPassword = '';
      // act
      sut.setPassword(invalidPassword);
      // assert
      expect(sut.invalidPassword, WARNING_INVALID_PASSWORD);
    });

    test('should reset warning message after user input a valid password', () {
      // arrange
      var invalidPassword = '';
      var validPassword = 'sTr0ng';
      // act
      sut.setPassword(invalidPassword);
      sut.setPassword(validPassword);
      // assert
      expect(sut.invalidPassword, '');
    });

    test(
        'should hasValidEmailAndPassword be false for invalid password and/or email',
        () {
      // arrange
      var invalidEmailAddress = 'myaddress';
      var invalidPassword = '';
      // act
      sut.setPassword(invalidPassword);
      sut.setEmail(invalidEmailAddress);
      // assert
      expect(sut.hasValidEmailAndPassword, false);
    });

    test('should hasValidEmailAndPassword be false for on start', () {
      expect(sut.hasValidEmailAndPassword, false);
    });

    test(
        'should hasValidEmailAndPassword be true for valid password and/or email',
        () {
      // arrange
      var validPassword = 'sTr0ng';
      var validEmailAddress = 'my_email@app.com';
      // act
      sut.setPassword(validPassword);
      sut.setEmail(validEmailAddress);
      // assert
      expect(sut.hasValidEmailAndPassword, true);
    });

    test("should validate inputs before hits repository", () async {
      // arrange
      when(mock.signInWithEmailAndPassword(
        emailAddress: anyNamed('emailAddress'),
        password: anyNamed('password'),
      )).thenThrow(UnimplementedError());

      // act
      await sut.login();
      // assert
      // verify(mockAuthenticatonRepository.signInWithEmailAndPassword(
      // emailAddress: emailAddress, password: password));
      // verifyNoMoreInteractions(mockAuthenticatonRepository);

      verifyZeroInteractions(mock);
      // expect(sut.serverErrorMessage, '');
    });

    // test("should validate inputs before hits repository", () async {
    //   // arrange
    //   var validPassword = 'sTr0ng';
    //   var validEmailAddress = 'my_email@app.com';
    //   // act
    //   sut.setPassword(validPassword);
    //   sut.setEmail(validEmailAddress);
    //   await sut.login();
    //   // assert
    //   // expect(sut.serverErrorMessage, '');
    // });
  });
}
