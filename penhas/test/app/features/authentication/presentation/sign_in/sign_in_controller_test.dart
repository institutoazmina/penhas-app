import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_controller.dart';

class MockAuthenticatonRepository extends AuthenticationRepository
    implements Mock {}

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
    test("should show warning message for invalid email address", () {
      // arrange
      var invalidEmailAddress = 'myaddress';
      // act
      sut.setEmail(invalidEmailAddress);
      // assert
      expect(sut.invalidEmailAddress, 'Endereço de email inválido');
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
      expect(sut.invalidPassword,
          'Senha inválido, favor informar uma senha válida');
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

    test('should be false actived for invalid password and/or email', () {
      // arrange
      var invalidEmailAddress = 'myaddress';
      var invalidPassword = '';
      // act
      sut.setPassword(invalidPassword);
      sut.setEmail(invalidEmailAddress);
      // assert
      expect(sut.hasValidEmailAndPassword, false);
    });

    test('should be true actived for valid password and/or email', () {
      // arrange
      var validPassword = 'sTr0ng';
      var validEmailAddress = 'my_email@app.com';
      // act
      sut.setPassword(validPassword);
      sut.setEmail(validEmailAddress);
      // assert
      expect(sut.hasValidEmailAndPassword, true);
    });
  });
}
