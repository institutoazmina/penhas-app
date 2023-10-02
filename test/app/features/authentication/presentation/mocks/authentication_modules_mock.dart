import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/authenticate_user.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';
import 'package:penhas/app/features/zodiac/domain/usecases/stealth_security_action.dart';

class AuthenticationModulesMock {
  static late IAuthenticationRepository authenticationRepository;
  static late PasswordValidator passwordValidator;
  static late IResetPasswordRepository resetPasswordRepository;
  static late IChangePasswordRepository changePasswordRepository;
  static late StealthSecurityAction securityAction;
  static late IUserRegisterRepository userRegisterRepository;
  static late AuthenticateUserUseCase autenticateUserUseCase;
  static late AuthenticateAnonymousUserUseCase authenticateAnonymousUserUseCase;
  static late AuthenticateStealthUserUseCase authenticateStealthUserUseCase;

  static void init() {
    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    passwordValidator = MockPasswordValidator();
    authenticationRepository = MockAuthenticationRepository();
    resetPasswordRepository = MockResetPasswordRepository();
    changePasswordRepository = MockChangePasswordRepository();
    securityAction = MockStealthSecurityAction();
    userRegisterRepository = MockUserRegisterRepository();

    autenticateUserUseCase = MockAuthenticateUserUseCase();
    authenticateAnonymousUserUseCase = MockAuthenticateAnonymousUserUseCase();
    authenticateStealthUserUseCase = MockAuthenticateStealthUserUseCase();
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

class MockResetPasswordRepository extends Mock
    implements IResetPasswordRepository {}

class MockChangePasswordRepository extends Mock
    implements IChangePasswordRepository {}

class MockStealthSecurityAction extends Mock implements StealthSecurityAction {}

class MockUserRegisterRepository extends Mock
    implements IUserRegisterRepository {}

class MockAuthenticateUserUseCase extends Mock
    implements AuthenticateUserUseCase {}

class MockAuthenticateStealthUserUseCase extends Mock
    implements AuthenticateStealthUserUseCase {}

class MockAuthenticateAnonymousUserUseCase extends Mock
    implements AuthenticateAnonymousUserUseCase {}

///
/// Fakes
///
class FakeEmailAddress extends Fake implements EmailAddress {}

class FakeSignInPassword extends Fake implements SignInPassword {}

class FakeAppStateEntity extends Fake implements AppStateEntity {}
