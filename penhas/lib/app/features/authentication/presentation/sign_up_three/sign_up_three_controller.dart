import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';
import 'package:penhas/app/features/authentication/presentation/sign_up/user_register_form_field_model.dart';

part 'sign_up_three_controller.g.dart';

const String WARNING_INVALID_EMAIL = 'Endereço de email inválido';
const String WARNING_INVALID_PASSWORD =
    'Senha precisa ter no mínimo 6 caracteres';
const String ERROR_SERVER_FAILURE =
    "O servidor está com problema neste momento, tente novamente.";
const String ERROR_INTERNET_CONNECTION_FAILURE =
    "O servidor está inacessível, o PenhaS está com acesso à Internet?";
const String INVALID_FIELD_TO_LOGIN =
    'E-mail e senha precisam estarem corretos para continuar.';

enum StoreState { initial, loading, loaded }

class SignUpThreeController extends _SignUpThreeControllerBase
    with _$SignUpThreeController {
  SignUpThreeController(IUserRegisterRepository repository,
      UserRegisterFormFieldModel userFormFielModel)
      : super(repository, userFormFielModel);
}

abstract class _SignUpThreeControllerBase with Store {
  final IUserRegisterRepository repository;
  final UserRegisterFormFieldModel _userRegisterModel;

  _SignUpThreeControllerBase(this.repository, this._userRegisterModel);

  @observable
  ObservableFuture<Either<Failure, SessionEntity>> _progress;

  @observable
  String errorMessage = '';

  @observable
  String warningEmail = '';

  @observable
  String warningPassword = '';

  @computed
  StoreState get currentState {
    if (_progress == null || _progress.status == FutureStatus.rejected) {
      return StoreState.initial;
    }

    return _progress.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

  @action
  void setEmail(String email) {
    _userRegisterModel.emailAddress = EmailAddress(email);

    warningEmail = _userRegisterModel.emailAddress.value.fold(
      (failure) => email.length == 0 ? '' : WARNING_INVALID_EMAIL,
      (_) => '',
    );
  }

  @action
  void setPassword(String password) {
    _userRegisterModel.password = Password(password);

    warningPassword = _userRegisterModel.password.value.fold(
      (failure) => password.length == 0 ? '' : WARNING_INVALID_PASSWORD,
      (_) => '',
    );
  }

  @action
  Future<void> registerUserPress() async {
    _setErrorMessage('');
    if (!_isValidToProceed()) {
      return;
    }

    _progress = ObservableFuture(
      repository.signup(
        emailAddress: _userRegisterModel.emailAddress,
        password: _userRegisterModel.password,
        cep: _userRegisterModel.cep,
        cpf: _userRegisterModel.cpf,
        fullname: _userRegisterModel.fullname,
        nickName: _userRegisterModel.nickname,
        birthday: _userRegisterModel.birthday,
        genre: _userRegisterModel.genre,
        race: _userRegisterModel.race,
      ),
    );

    final response = await _progress;
    response.fold(
      (failure) => _mapFailureToMessage(failure),
      (session) => _forwardToLogged(),
    );
  }

  void _setErrorMessage(String message) {
    errorMessage = message;
  }

  bool _isValidToProceed() {
    bool isValid = true;

    if (_userRegisterModel.emailAddress == null ||
        !_userRegisterModel.emailAddress.isValid) {
      isValid = false;
      warningEmail = WARNING_INVALID_EMAIL;
    }

    if (_userRegisterModel.password == null ||
        !_userRegisterModel.password.isValid) {
      isValid = false;
      warningPassword = WARNING_INVALID_PASSWORD;
    }

    return isValid;
  }

  _forwardToLogged() {
    Modular.to.pushReplacementNamed('/mainboard');
  }

  _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case InternetConnectionFailure:
        _setErrorMessage(ERROR_INTERNET_CONNECTION_FAILURE);
        break;
      case ServerFailure:
        _setErrorMessage(ERROR_SERVER_FAILURE);
        break;
      case ServerSideFormFieldValidationFailure:
        _mapFailureToFields(failure);
        break;
      default:
        throw UnsupportedError;
    }
  }

  _mapFailureToFields(ServerSideFormFieldValidationFailure failure) {
    _setErrorMessage(failure.message);
  }
}
