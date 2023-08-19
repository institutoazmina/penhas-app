import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';

class AuthenticationModulesMock {
  static late IAuthenticationRepository authenticationRepository;
  static late PasswordValidator passwordValidator;

  static void init() {
    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    passwordValidator = MockPasswordValidator();
    authenticationRepository = MockAuthenticationRepository();
  }

  static void _initFallbacks() {
    registerFallbackValue(FakeEmailAddress());
    registerFallbackValue(FakeSignInPassword());
  }
}

///
/// Mocks
///
class MockAuthenticationRepository extends Mock
    implements IAuthenticationRepository {}

class MockPasswordValidator extends Mock implements PasswordValidator {}

///
/// Fakes
///
class FakeEmailAddress extends Fake implements EmailAddress {}

class FakeSignInPassword extends Fake implements SignInPassword {}

class FakeAppStateEntity extends Fake implements AppStateEntity {}
