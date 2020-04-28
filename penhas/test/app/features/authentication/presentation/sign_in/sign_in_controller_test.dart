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
    test("should show error message for invalid email address", () {
      // arrange
      var invalidEmailAddress = 'myaddress';
      // act
      sut.setEmail(invalidEmailAddress);
      // assert
      expect(sut.invalidEmailAddress, 'Endereço de email inválido');
    });
  });
}
