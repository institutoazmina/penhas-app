import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

part 'sign_in_controller.g.dart';

const String WARNING_INVALID_EMAIL = 'Endereço de email inválido';
const String WARNING_INVALID_PASSWORD =
    'Senha precisa ter no mínimo 6 caracteres';
const String ERROR_SERVER_FAILURE =
    "O servidor está com problema neste momento, tente novamente.";
const String ERROR_INTERNET_CONNECTION_FAILURE =
    "O servidor está inacessível, o PenhaS está com acesso à Internet?";
const String ERROR_USER_AUTHENTICATION_FAILURE =
    "Usuário ou senha inválida, favor verificar!";
const String INVALID_FIELD_TO_LOGIN =
    'E-mail e senha precisam estarem corretos para continuar.';

class SignInController extends _SignInControllerBase with _$SignInController {
  SignInController(IAuthenticationRepository repository) : super(repository);
}

abstract class _SignInControllerBase with Store {
  final IAuthenticationRepository repository;
  EmailAddress _emailAddress = EmailAddress("");
  Password _password = Password("");

  _SignInControllerBase(this.repository);

  @observable
  String warningEmail = "";

  @observable
  String warningPassword = "";

  @observable
  String errorAuthenticationMessage = "";

  @action
  void setEmail(String address) {
    _emailAddress = EmailAddress(address);

    warningEmail = _emailAddress.value.fold(
      (failure) => address.length == 0 ? '' : WARNING_INVALID_EMAIL,
      (_) => '',
    );
  }

  @action
  void resetErrorMessage() {
    _setErrorMessage("");
  }

  @action
  void setPassword(String password) {
    _password = Password(password);

    warningPassword = _password.value.fold(
      (failure) => password.length == 0 ? '' : WARNING_INVALID_PASSWORD,
      (_) => '',
    );
  }

  @action
  Future<void> signInWithEmailAndPasswordPressed() async {
    if (!_emailAddress.isValid || !_password.isValid) {
      _setErrorMessage(INVALID_FIELD_TO_LOGIN);
      return;
    }

    final response = await repository.signInWithEmailAndPassword(
      emailAddress: _emailAddress,
      password: _password,
    );

    response.fold(
      (failure) => _mapFailureToMessage(failure),
      (session) => _forwardToLogged(),
    );
  }

  @action
  Future<void> registerUserPressed() async {
    Modular.to.pushNamed('/authentication/signup');
  }

  @action
  Future<void> resetPasswordPressed() async {
    Modular.to.pushNamed('/authentication/reset_password');
  }

  _forwardToLogged() {
    Modular.to.pushReplacementNamed('/');
  }

  void _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case InternetConnectionFailure:
        _setErrorMessage(ERROR_INTERNET_CONNECTION_FAILURE);
        break;
      case ServerFailure:
        _setErrorMessage(ERROR_SERVER_FAILURE);
        break;
      case UserAuthenticationFailure:
        _setErrorMessage(ERROR_USER_AUTHENTICATION_FAILURE);
        break;
      case ServerSideFormFieldValidationFailure:
        final msg = failure as ServerSideFormFieldValidationFailure;
        _setErrorMessage(msg.message);
        break;
      default:
        throw UnsupportedError;
    }
  }

  void _setErrorMessage(String msg) {
    errorAuthenticationMessage = msg;
  }
}
