import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';

part 'reset_password_three_controller.g.dart';

const String ERROR_SERVER_FAILURE =
    "O servidor está com problema neste momento, tente novamente.";
const String ERROR_INTERNET_CONNECTION_FAILURE =
    "O servidor está inacessível, o PenhaS está com acesso à Internet?";
const String WARNING_INVALID_PASSWORD = 'Senha inválid';

class ResetPasswordThreeController extends _ResetPasswordThreeControllerBase
    with _$ResetPasswordThreeController {
  ResetPasswordThreeController(
    IChangePasswordRepository repository,
    UserRegisterFormFieldModel userRegisterModel,
  ) : super(repository, userRegisterModel);
}

enum StoreState { initial, loading, loaded }

abstract class _ResetPasswordThreeControllerBase with Store {
  final IChangePasswordRepository _repository;
  final UserRegisterFormFieldModel _userRegisterModel;

  _ResetPasswordThreeControllerBase(this._repository, this._userRegisterModel);

  @observable
  ObservableFuture<Either<Failure, ValidField>> _progress;

  @observable
  String errorMessage = '';

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
  void setPassword(String password) {
    _userRegisterModel.password = Password(password);

    warningPassword = _userRegisterModel.password.value.fold(
      (failure) => password.length == 0 ? '' : WARNING_INVALID_PASSWORD,
      (_) => '',
    );
  }

  @action
  Future<void> nextStepPressed() async {
    _setErrorMessage('');
    if (!_isValidToProceed()) {
      return;
    }

    _progress = ObservableFuture(
      _repository.reset(
        emailAddress: _userRegisterModel.emailAddress,
        password: _userRegisterModel.password,
        resetToken: _userRegisterModel.token,
      ),
    );

    final response = await _progress;
    response.fold(
      (failure) => _mapFailureToMessage(failure),
      (session) => _forwardLogin(),
    );
  }

  void _setErrorMessage(String s) {
    errorMessage = s;
  }

  bool _isValidToProceed() {
    bool isValid = true;

    if (_userRegisterModel.password == null ||
        !_userRegisterModel.password.isValid) {
      isValid = false;
      warningPassword = WARNING_INVALID_PASSWORD;
    }

    return isValid;
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

  void _forwardLogin() {
    Modular.to.pushReplacementNamed('/authentication');
  }
}
